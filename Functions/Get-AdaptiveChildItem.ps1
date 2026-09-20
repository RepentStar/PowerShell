# Item count at which `ls` switches from the detailed table to a compact view.
# Override this in the profile before the Functions directory is loaded if needed.
if (-not (Get-Variable -Name AdaptiveLsCompactThreshold -Scope Global -ErrorAction Ignore)) {
    $global:AdaptiveLsCompactThreshold = 20
}

function Get-AdaptiveLsDisplayWidth {
    param([AllowEmptyString()][string] $Text)

    # Formatting modules such as Terminal-Icons add ANSI escape sequences. They
    # occupy characters in the string, but no cells in the terminal.
    $plainText = [regex]::Replace($Text, "`e\[[0-?]*[ -/]*[@-~]", '')
    $width = 0
    $elements = [Globalization.StringInfo]::GetTextElementEnumerator($plainText)

    while ($elements.MoveNext()) {
        $element = [string] $elements.Current
        $codePoint = [char]::ConvertToUtf32($element, 0)
        $category = [Globalization.CharUnicodeInfo]::GetUnicodeCategory($element, 0)

        if ($category -in @(
            [Globalization.UnicodeCategory]::Control,
            [Globalization.UnicodeCategory]::NonSpacingMark,
            [Globalization.UnicodeCategory]::EnclosingMark,
            [Globalization.UnicodeCategory]::Format
        )) {
            continue
        }

        # CJK/full-width characters and emoji normally occupy two terminal
        # cells. Nerd Font glyphs live in the private-use area and intentionally
        # fall through as one cell.
        $isWide =
            ($codePoint -ge 0x1100 -and $codePoint -le 0x115F) -or
            ($codePoint -in 0x2329, 0x232A) -or
            ($codePoint -ge 0x2E80 -and $codePoint -le 0xA4CF) -or
            ($codePoint -ge 0xAC00 -and $codePoint -le 0xD7A3) -or
            ($codePoint -ge 0xF900 -and $codePoint -le 0xFAFF) -or
            ($codePoint -ge 0xFE10 -and $codePoint -le 0xFE19) -or
            ($codePoint -ge 0xFE30 -and $codePoint -le 0xFE6F) -or
            ($codePoint -ge 0xFF00 -and $codePoint -le 0xFF60) -or
            ($codePoint -ge 0xFFE0 -and $codePoint -le 0xFFE6) -or
            ($codePoint -ge 0x1F000 -and $codePoint -le 0x1FAFF) -or
            ($codePoint -ge 0x20000 -and $codePoint -le 0x3FFFD) -or
            $element.Contains([char] 0xFE0F)

        $width += if ($isWide) { 2 } else { 1 }
    }

    $width
}

function Format-AdaptiveLsCompact {
    param(
        [Parameter(Mandatory)][object[]] $InputObject,
        [int] $Width = 0
    )

    if ($Width -le 0) {
        try {
            # Leave the last cell unused so a full row does not wrap on hosts
            # that wrap immediately at the right edge.
            $Width = [Math]::Max(20, $Host.UI.RawUI.WindowSize.Width - 1)
        } catch {
            $Width = 119
        }
    }

    $terminalIcons = Get-Command Terminal-Icons\Format-TerminalIcons -ErrorAction Ignore
    $entries = @(
        foreach ($item in $InputObject) {
            $text = if ($terminalIcons -and $item -is [IO.FileSystemInfo]) {
                Terminal-Icons\Format-TerminalIcons -FileInfo $item
            } elseif ($item -is [string]) {
                $item
            } elseif ($null -ne $item.Name) {
                [string] $item.Name
            } else {
                [string] $item
            }

            [pscustomobject]@{
                Text  = [string] $text
                Width = Get-AdaptiveLsDisplayWidth ([string] $text)
            }
        }
    )

    $spacing = 2
    $columnCount = 1
    $columnWidths = @([int] ($entries | Measure-Object Width -Maximum).Maximum)
    $minimumWidth = [int] ($entries | Measure-Object Width -Minimum).Minimum
    $maximumColumns = [Math]::Min(
        $entries.Count,
        [Math]::Max(1, [Math]::Floor(($Width + $spacing) / ($minimumWidth + $spacing)))
    )

    # Use the greatest number of columns that really fits. Measuring each
    # column separately avoids one long name wasting space in every column.
    for ($candidate = $maximumColumns; $candidate -ge 2; $candidate--) {
        $rowCount = [int] [Math]::Ceiling($entries.Count / $candidate)
        $candidateWidths = for ($column = 0; $column -lt $candidate; $column++) {
            $start = $column * $rowCount
            $end = [Math]::Min($start + $rowCount, $entries.Count)
            if ($start -ge $end) { 0 } else {
                [int] ($entries[$start..($end - 1)] | Measure-Object Width -Maximum).Maximum
            }
        }

        if ((($candidateWidths | Measure-Object -Sum).Sum + $spacing * ($candidate - 1)) -le $Width) {
            $columnCount = $candidate
            $columnWidths = @($candidateWidths)
            break
        }
    }

    $rowCount = [int] [Math]::Ceiling($entries.Count / $columnCount)
    for ($row = 0; $row -lt $rowCount; $row++) {
        $line = [Text.StringBuilder]::new()
        for ($column = 0; $column -lt $columnCount; $column++) {
            $index = $row + $column * $rowCount
            if ($index -ge $entries.Count) { continue }

            $entry = $entries[$index]
            [void] $line.Append($entry.Text)

            $nextIndex = $row + ($column + 1) * $rowCount
            if ($column -lt ($columnCount - 1) -and $nextIndex -lt $entries.Count) {
                [void] $line.Append(' ' * ($columnWidths[$column] - $entry.Width + $spacing))
            }
        }
        $line.ToString()
    }
}

function Get-AdaptiveChildItem {
    [CmdletBinding(DefaultParameterSetName = 'Items')]
    param(
        [Parameter(Position = 0, ParameterSetName = 'Items')]
        [string[]] $Path,

        [Parameter(Mandatory, ParameterSetName = 'LiteralItems')]
        [Alias('PSPath', 'LP')]
        [string[]] $LiteralPath,

        [Parameter(Position = 1)]
        [string] $Filter,

        [string[]] $Include,
        [string[]] $Exclude,
        [Alias('R')]
        [switch] $Recurse,
        [uint32] $Depth,

        # Unix-style ls compatibility. PowerShell does not split a token such
        # as -al into -a and -l, so the common combined forms are declared
        # explicitly below.
        [Alias('a', 'All')]
        [switch] $Force,

        [Alias('l')]
        [switch] $Long,

        [Alias('al', 'la')]
        [switch] $AllLong,

        [switch] $Name,
        [System.Management.Automation.FlagsExpression[System.IO.FileAttributes]] $Attributes,
        [switch] $FollowSymlink,
        [switch] $Directory,
        [switch] $File,
        [switch] $Hidden,
        [switch] $ReadOnly,
        [switch] $System
    )

    $childItemParameters = @{}
    foreach ($parameter in $PSBoundParameters.GetEnumerator()) {
        $childItemParameters[$parameter.Key] = $parameter.Value
    }
    [void] $childItemParameters.Remove('Long')
    [void] $childItemParameters.Remove('AllLong')

    if ($AllLong) {
        $childItemParameters.Force = $true
    }

    # Buffering is intentional: the layout depends on the total item count.
    $items = @(Microsoft.PowerShell.Management\Get-ChildItem @childItemParameters)

    if ($items.Count -eq 0) {
        return
    }

    if ($Long -or $AllLong -or $items.Count -le $global:AdaptiveLsCompactThreshold) {
        $items | Format-Table
    } else {
        Format-AdaptiveLsCompact -InputObject $items
    }
}

# Keep Get-ChildItem itself pipeline-friendly; only make its interactive alias
# use the adaptive, display-oriented wrapper.
Set-Alias -Name ls -Value Get-AdaptiveChildItem -Scope Global -Force
