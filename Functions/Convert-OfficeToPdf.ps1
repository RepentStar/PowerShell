function Convert-OfficeToPdf {
    <#
    .SYNOPSIS
        在 Windows 桌面版 Office 中批量导出 PDF
    .PARAMETER Path
        要扫描的文件系统目录，按字面值解释
    .PARAMETER Filter
        文件名通配符，例如 *.doc? 或 报告_*.xlsx
    .PARAMETER OutputDir
        PDF 输出根目录；保留相对于 Path 的子目录结构
        不指定时，PDF 写在源文件旁边
    .PARAMETER Recurse
        扫描子目录
    .PARAMETER Force
        允许替换已有 PDF，不解决多个源文件映射到同一目标的冲突
    .EXAMPLE
        Convert-OfficeToPdf -Path 'D:\docs' -Recurse -OutputDir 'D:\pdf' -WhatIf
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Path,

        [ValidateNotNullOrEmpty()]
        [string]$Filter = '*',

        [ValidateNotNullOrEmpty()]
        [string]$OutputDir,

        [switch]$Recurse,
        [switch]$Force
    )

    if ([Environment]::OSVersion.Platform -ne [PlatformID]::Win32NT) {
        throw '此函数需要 Windows 和桌面版 Microsoft Office。'
    }

    $root = Get-Item -LiteralPath $Path -ErrorAction Stop
    if ($root -isnot [System.IO.DirectoryInfo]) {
        throw "Path 必须是文件系统目录：$Path"
    }

    $rootPrefix = $root.FullName.TrimEnd([char[]]@('\', '/')) + '\'
    $outRoot = $null
    if ($PSBoundParameters.ContainsKey('OutputDir')) {
        $provider = $null
        $drive = $null
        $outRoot = $ExecutionContext.SessionState.Path.
            GetUnresolvedProviderPathFromPSPath($OutputDir, [ref]$provider, [ref]$drive)
        if ($provider.Name -ne 'FileSystem') {
            throw "OutputDir 必须是文件系统路径：$OutputDir"
        }
    }

    $appMap = @{
        '.doc' = 'Word'; '.docx' = 'Word'; '.docm' = 'Word'; '.rtf' = 'Word'
        '.xls' = 'Excel'; '.xlsx' = 'Excel'; '.xlsm' = 'Excel'
        '.ppt' = 'PowerPoint'; '.pptx' = 'PowerPoint'; '.pptm' = 'PowerPoint'
    }

    $jobs = @(
        Get-ChildItem -LiteralPath $root.FullName -File -Recurse:$Recurse -ErrorAction Stop |
            Where-Object {
                $_.Name -like $Filter -and
                -not $_.Name.StartsWith('~$') -and
                $appMap.ContainsKey($_.Extension)
            } |
            ForEach-Object {
                $pdf = if ($outRoot) {
                    $relative = $_.FullName.Substring($rootPrefix.Length)
                    [IO.Path]::Combine($outRoot, [IO.Path]::ChangeExtension($relative, '.pdf'))
                } else {
                    [IO.Path]::ChangeExtension($_.FullName, '.pdf')
                }

                [pscustomobject]@{
                    File = $_.FullName
                    Pdf  = $pdf
                    App  = $appMap[$_.Extension]
                }
            }
    )

    if ($jobs.Count -eq 0) {
        Write-Verbose '未找到匹配的 Office 文件。'
        return
    }

    $targetCounts = @{}
    foreach ($job in $jobs) {
        $targetCounts[$job.Pdf] = 1 + [int]$targetCounts[$job.Pdf]
    }

    function Release-OfficeComObject {
        param($Object)
        if ($null -ne $Object -and
            [Runtime.InteropServices.Marshal]::IsComObject($Object)) {
            try {
                [void][Runtime.InteropServices.Marshal]::ReleaseComObject($Object)
            } catch {
                Write-Warning "释放 COM 对象失败：$($_.Exception.Message)"
            }
        }
    }

    $apps = @{}

    try {
        foreach ($job in $jobs) {
            $result = [pscustomobject]@{
                File = $job.File; Pdf = $job.Pdf; Status = $null; Message = $null
            }

            $doc = $null
            $collection = $null
            $tempPdf = $null

            try {
                if ($targetCounts[$job.Pdf] -gt 1) {
                    $result.Status = 'Conflict'
                    $result.Message = '多个源文件映射到同一 PDF；没有写入。'
                } elseif ([IO.Directory]::Exists($job.Pdf)) {
                    throw "目标路径是目录：$($job.Pdf)"
                } elseif (-not $Force -and [IO.File]::Exists($job.Pdf)) {
                    $result.Status = 'Skipped'
                    $result.Message = 'PDF 已存在。'
                } elseif (-not $PSCmdlet.ShouldProcess(
                    $job.Pdf, "将 '$($job.File)' 导出为 PDF"
                )) {
                    $result.Status = if ($WhatIfPreference) { 'WhatIf' } else { 'Skipped' }
                } else {
                    $kind = $job.App
                    if (-not $apps.ContainsKey($kind)) {
                        $type = [Type]::GetTypeFromProgID("$kind.Application")
                        if ($null -eq $type) {
                            throw "未注册 $kind COM 组件；请检查桌面版 Office 安装。"
                        }
                        $apps[$kind] = [Activator]::CreateInstance($type)
                    }
                    $app = $apps[$kind]

                    $destDir = [IO.Path]::GetDirectoryName($job.Pdf)
                    [void][IO.Directory]::CreateDirectory($destDir)
                    $tempPdf = [IO.Path]::Combine(
                        $destDir, ('.office-' + [guid]::NewGuid().ToString('N') + '.pdf')
                    )

                    $oldSecurity = $app.AutomationSecurity
                    $oldAlerts = $app.DisplayAlerts
                    try {
                        $app.AutomationSecurity = 3  # msoAutomationSecurityForceDisable
                        switch ($kind) {
                            'Word' {
                                $app.DisplayAlerts = 0
                                $collection = $app.Documents
                                $doc = $collection.Open($job.File, $false, $true)
                                $doc.ExportAsFixedFormat($tempPdf, 17)
                            }
                            'Excel' {
                                $app.DisplayAlerts = $false
                                $collection = $app.Workbooks
                                # UpdateLinks = 0, ReadOnly = true
                                $doc = $collection.Open($job.File, 0, $true)
                                $doc.ExportAsFixedFormat(0, $tempPdf)
                            }
                            'PowerPoint' {
                                $app.DisplayAlerts = 1  # ppAlertsNone
                                $collection = $app.Presentations
                                # ReadOnly, Untitled, WithWindow
                                $doc = $collection.Open($job.File, -1, 0, 0)
                                $doc.SaveCopyAs($tempPdf, 32)  # ppSaveAsPDF
                            }
                        }
                    } finally {
                        if ($null -ne $doc) {
                            try {
                                switch ($kind) {
                                    'Word'       { $doc.Close(0) }
                                    'Excel'      { $doc.Close($false) }
                                    'PowerPoint' { $doc.Close() }
                                }
                            } catch {
                                Write-Warning "关闭 '$($job.File)' 失败：$($_.Exception.Message)"
                            } finally {
                                Release-OfficeComObject $doc
                            }
                        }
                        Release-OfficeComObject $collection

                        try { $app.DisplayAlerts = $oldAlerts }
                        catch { Write-Warning "恢复 $kind 提示设置失败：$($_.Exception.Message)" }

                        try { $app.AutomationSecurity = $oldSecurity }
                        catch { Write-Warning "恢复 $kind 宏安全设置失败：$($_.Exception.Message)" }
                    }

                    if (-not [IO.File]::Exists($tempPdf) -or
                        ([IO.FileInfo]::new($tempPdf)).Length -eq 0) {
                        throw 'Office 未生成非空的 PDF。'
                    }

                    if ($Force -and [IO.File]::Exists($job.Pdf)) {
                        [IO.File]::Replace($tempPdf, $job.Pdf, $null)
                    } else {
                        # Move 不覆盖；即使转换期间目标被其他程序创建，也不会踩掉它
                        [IO.File]::Move($tempPdf, $job.Pdf)
                    }
                    $result.Status = 'OK'
                }
            } catch {
                $result.Status = 'Failed'
                $result.Message = $_.Exception.Message
            } finally {
                if ($tempPdf -and [IO.File]::Exists($tempPdf)) {
                    try { [IO.File]::Delete($tempPdf) }
                    catch { Write-Warning "无法删除临时文件 '$tempPdf'：$($_.Exception.Message)" }
                }
            }

            $result
        }
    } finally {
        foreach ($kind in $apps.Keys) {
            $app = $apps[$kind]
            $openItems = $null
            try {
                switch ($kind) {
                    'Word'       { $openItems = $app.Documents }
                    'Excel'      { $openItems = $app.Workbooks }
                    'PowerPoint' { $openItems = $app.Presentations }
                }

                if ($openItems.Count -eq 0) {
                    $app.Quit()
                } else {
                    Write-Warning "$kind 仍有打开的文件，未调用 Quit()。请检查窗口。"
                }
            } catch {
                Write-Warning "退出 $kind 失败：$($_.Exception.Message)"
            } finally {
                Release-OfficeComObject $openItems
                Release-OfficeComObject $app
            }
        }
    }
}
