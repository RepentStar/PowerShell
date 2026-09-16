# PSCompletions completion for onomedit
# 生成: onomedit completion psc
# 用法: 配合 PSCompletions 模块（候选带 tip 提示）。把本脚本存为独立文件后在
#       $PROFILE 中 . 加载，或按 PSCompletions 的做法放置为补全文件。

Register-ArgumentCompleter -CommandName onomedit, onomedit.exe -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()

    # 已敲入的完成参数；不含正在补全的半截词，由 prevIdx 处理。
    $tokens = $commandAst.CommandElements | ForEach-Object { $_.Extent.Text }
    $cmds = 'completion config gui help history rename restore version'.Split(' ')
    # 仅当 $tokens[1] 完整命中已知子命令才视为子命令；否则视为第一级补全——
    # CommandElements 会把正在补全的半截词也算作元素，直接取 $tokens[1] 会让
    # 一级子命令补全失效。
    $cmd = if ($tokens.Count -gt 1 -and $cmds -contains $tokens[1]) { $tokens[1] } else { '' }

    # 子命令候选（带 tip）
    $commands = @(
        @{ name='completion'; tip='生成 shell 补全脚本' }
        @{ name='config'; tip='查看/设置配置' }
        @{ name='gui'; tip='启动图形界面' }
        @{ name='help'; tip='显示帮助信息' }
        @{ name='history'; tip='查看重命名日志' }
        @{ name='rename'; tip='编辑器模式批量重命名' }
        @{ name='restore'; tip='恢复重命名' }
        @{ name='version'; tip='版本信息' }
    )

    # 值型选项 -> 取值候选（带 tip）
    $valueMap = @{
        '--path-type' = @(
            @{ name='full'; tip='完整路径' },
            @{ name='name'; tip='完整文件名' },
            @{ name='stem'; tip='不含扩展名' },
            @{ name='ext'; tip='仅扩展名' }
        )
        '--sort-by' = @(
            @{ name='default'; tip='默认' },
            @{ name='name'; tip='名称' },
            @{ name='path'; tip='路径' },
            @{ name='mtime'; tip='修改时间' },
            @{ name='ctime'; tip='创建时间' },
            @{ name='size'; tip='大小' }
        )
        '--exclude' = @(
            @{ name='f'; tip='文件' },
            @{ name='file'; tip='文件' },
            @{ name='d'; tip='目录' },
            @{ name='dir'; tip='目录' },
            @{ name='l'; tip='链接' },
            @{ name='link'; tip='链接' },
            @{ name='r'; tip='只读' },
            @{ name='readonly'; tip='只读' },
            @{ name='h'; tip='隐藏' },
            @{ name='hidden'; tip='隐藏' },
            @{ name='s'; tip='系统' },
            @{ name='system'; tip='系统' }
        )
    }

    # rename 子命令的选项候选（带 tip）；布尔选项与值型选项
    $renameOpts = @(
        @{ name='--dry-run'; tip='预览不执行' }
        @{ name='--no-editor'; tip='跳过编辑器直接重命名' }
        @{ name='--multi-tab'; tip='多标签编辑器适配' }
        @{ name='--reverse'; tip='反转排序顺序' }
        @{ name='--timeout'; tip='编辑器等待超时（秒）' }
        @{ name='--depth'; tip='目录搜索深度（层级）' }
        @{ name='--sort-by'; tip='重命名顺序' }
        @{ name='--exclude'; tip='排除的类型' }
        @{ name='--path-type'; tip='路径类型' }
    )

    # 值型选项判断：末位已是完成选项看末位；末位是正补的取值则看前一个。
    $prevIdx = if ($tokens.Count -gt 1 -and $tokens[-1] -eq $wordToComplete -and $wordToComplete -ne '') {
        $tokens.Count - 2
    } else {
        $tokens.Count - 1
    }
    $last = if ($prevIdx -ge 0) { $tokens[$prevIdx] } else { '' }
    if ($valueMap.ContainsKey($last)) {
        $valueMap[$last] | Where-Object { $_.name -like "$wordToComplete*" } |
            ForEach-Object { [System.Management.Automation.CompletionResult]::new($_.name, $_.name, 'ParameterValue', $_.tip) }
        return
    }

    $candidates = @()
    switch ($cmd) {
        ''           { $candidates = $commands }
        'rename'     { $candidates = $renameOpts }
        'restore'    { $candidates = @(@{ name='--all'; tip='恢复全部历史' }, @{ name='--partial'; tip='用编辑器筛选日志行' }) }
        'history'    { $candidates = @(@{ name='--all'; tip='查看全部历史' }) }
        'config'     { $candidates = @(@{ name='set'; tip='设置配置项' }, @{ name='set-editor'; tip='设置编辑器' }, @{ name='reset'; tip='重置默认配置' }) }
        'completion' { $candidates = @(
            @{ name='bash'; tip='生成 bash 补全' }
            @{ name='zsh'; tip='生成 zsh 补全' }
            @{ name='pwsh'; tip='生成 pwsh 补全' }
            @{ name='fish'; tip='生成 fish 补全' }
            @{ name='psc'; tip='生成 psc 补全' }
        ) }
        'help'       { $candidates = $commands }
        default      { $candidates = @() }
    }

    $candidates | Where-Object { $_.name -like "$wordToComplete*" } |
        ForEach-Object { [System.Management.Automation.CompletionResult]::new($_.name, $_.name, 'ParameterValue', $_.tip) }
}
