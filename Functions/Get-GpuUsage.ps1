function Get-GpuUsage {
    <#
    .SYNOPSIS
    Monitors per-process GPU engine use and dedicated memory in PowerShell on Windows.

    .DESCRIPTION
    Refreshes every second by default. GPU (%) is the highest engine utilization
    for each process and adapter in the current sample. Dedicated memory is shown
    in MiB. NVIDIA adapter totals are refreshed when nvidia-smi is available.

    .PARAMETER IntervalSeconds
    Time between samples in seconds. The default is 1.

    .PARAMETER Samples
    Number of refreshes. The default of 0 runs until you press Ctrl+C.

    .EXAMPLE
    . .\Get-GpuUsage.ps1
    Get-GpuUsage

    .EXAMPLE
    Get-GpuUsage -Samples 8 -IntervalSeconds 2
    #>
    [CmdletBinding()]
    param(
        [ValidateRange(0, 3600)]
        [int]$Samples = 0,

        [ValidateRange(1, 3600)]
        [int]$IntervalSeconds = 1
    )

    $counterParameters = @{
        Counter = @(
            '\GPU Engine(*)\Utilization Percentage'
            '\GPU Process Memory(*)\Dedicated Usage'
        )
        SampleInterval = $IntervalSeconds
        ErrorAction = 'Stop'
    }
    if ($Samples -eq 0) {
        $counterParameters.Continuous = $true
    } else {
        $counterParameters.MaxSamples = $Samples
    }

    $instancePattern = '^pid_(?<ProcessId>\d+)_luid_(?<Luid>0x[0-9a-f]+_0x[0-9a-f]+)_phys_(?<Physical>\d+)(?:_eng_\d+_engtype_(?<Engine>.+))?$'
    $nvidiaSmi = Get-Command nvidia-smi -CommandType Application -ErrorAction SilentlyContinue |
        Select-Object -First 1
    $clearScreen = $Host.Name -eq 'ConsoleHost' -and -not [Console]::IsOutputRedirected

    Get-Counter @counterParameters | ForEach-Object {
        $timestamp = $_.Timestamp
        $usage = @{}
        foreach ($sample in $_.CounterSamples) {
            if ($sample.Status -notin 0, 1 -or $sample.CookedValue -le 0 -or
                $sample.InstanceName -notmatch $instancePattern) {
                continue
            }

            $processId = [int]$Matches.ProcessId
            $adapter = '{0}/{1}' -f $Matches.Luid, $Matches.Physical
            $engine = $Matches['Engine']
            $key = "$adapter/$processId"

            if (-not $usage.ContainsKey($key)) {
                $usage[$key] = [pscustomobject]@{
                    Adapter        = $adapter
                    PID            = $processId
                    Engine         = $null
                    Percent        = 0.0
                    DedicatedBytes = 0.0
                }
            }

            $entry = $usage[$key]
            if ($engine) {
                if ($sample.CookedValue -gt $entry.Percent) {
                    $entry.Engine = $engine
                    $entry.Percent = $sample.CookedValue
                }
            } elseif ($sample.Path -like '*\dedicated usage') {
                $entry.DedicatedBytes = [math]::Max($entry.DedicatedBytes, $sample.CookedValue)
            }
        }

        $processTable = 'No GPU activity or dedicated memory in this sample.'
        if ($usage.Count -gt 0) {
            $processNames = @{}
            Get-Process | ForEach-Object { $processNames[$_.Id] = $_.ProcessName }
            $processTable = $usage.Values |
                Sort-Object Adapter, @{ Expression = 'Percent'; Descending = $true },
                    @{ Expression = 'DedicatedBytes'; Descending = $true }, PID |
                Format-Table -AutoSize Adapter, PID,
                    @{ Label = 'Process'; Expression = { $processNames[$_.PID] } },
                    Engine,
                    @{ Label = 'GPU (%)'; Expression = { '{0:F2}' -f $_.Percent }; Alignment = 'Right' },
                    @{ Label = 'Dedicated (MiB)'; Expression = { '{0:F1}' -f ($_.DedicatedBytes / 1MB) }; Alignment = 'Right' } |
                Out-String
        }

        $frame = @(
            ('GPU usage by process and adapter (LUID/physical index) | {0:yyyy-MM-dd HH:mm:ss}' -f $timestamp)
            $processTable.Trim()
        )
        if ($nvidiaSmi) {
            $PSNativeCommandUseErrorActionPreference = $false
            $adapterTotals = & $nvidiaSmi.Source '--query-gpu=index,name,utilization.gpu,memory.used,memory.total' '--format=csv' 2>$null
            $frame += '', 'NVIDIA adapter totals'
            if ($LASTEXITCODE -eq 0) {
                $frame += $adapterTotals
            } else {
                $frame += "nvidia-smi exited with code $LASTEXITCODE."
            }
        }

        if ($clearScreen) {
            Clear-Host
        }
        Write-Host ($frame -join [Environment]::NewLine)
    }
}
