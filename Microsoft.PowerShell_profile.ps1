# Remove build in Alias
@(
    'rm', 'rmdir', 'mv', 'cp', 'cat', 'curl', 'wget',
    'ls', 'diff', 'sort', 'tee', 'echo', 'sleep', 'where'
) | ForEach-Object {
    if (Get-Alias $_ -ErrorAction SilentlyContinue) {
        Remove-Alias $_ -Force -ErrorAction SilentlyContinue
    }
}

# Alias
Set-Alias nv nvim -Force -Option AllScope
function Back-Previous { cd .. }
Set-Alias bd Back-Previous

# starship
Invoke-Expression (&starship init powershell)

# zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# auto suggestions
Import-Module PSReadLine
Set-PSReadLineOption -PredictionViewStyle ListView -BellStyle None -EditMode Windows
Set-PSReadLineKeyHandler -Key 'Ctrl+z' -Function Undo
Set-PSReadLineOption -Colors @{
    Parameter       = '#98FB98'
}
Import-Module CompletionPredictor

# Custom Module
Import-Module Terminal-Icons
Import-Module PSCompletions

# Autocomplete
. "$HOME\Documents\PowerShell\Completions\_bat.ps1"
. "$HOME\Documents\PowerShell\Completions\_fd.ps1"
. "$HOME\Documents\PowerShell\Completions\_zoxide.ps1"
. "$HOME\Documents\PowerShell\Completions\_onomedit.ps1"

. "$HOME\Documents\PowerShell\Completions\psc_onomedit.ps1"

# Function
$functionsDir = "$HOME\Documents\PowerShell\Functions"
if (-not (Test-Path $functionsDir)) {
    Write-Warning "Functions directory not found: $functionsDir"
} else {
    Get-ChildItem -Path $functionsDir -Filter *.ps1 -File | ForEach-Object {
        try {
            . $_.FullName
        } catch {
            Write-Warning "Failed to load $($_.Name): $_"
        }
    }
}
