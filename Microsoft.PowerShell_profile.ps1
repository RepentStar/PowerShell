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
Import-Module CompletionPredictor

# Custom Module
Import-Module Terminal-Icons
Import-Module PSCompletions

function File {
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
        [string]$file
    )
    process {
        Get-Item -Path $file | Format-List *
    }
}

function reload { . $PROFILE; Write-Host "Profile reloaded!" -ForegroundColor Green }

# Autocomplete
. "$HOME\Documents\PowerShell\Completions\_bat.ps1"
. "$HOME\Documents\PowerShell\Completions\_fd.ps1"
. "$HOME\Documents\PowerShell\Completions\_zoxide.ps1"

. "$HOME\Documents\PowerShell\Completions\psc_winget.ps1"
. "$HOME\Documents\PowerShell\Completions\psc_onomedit.ps1"
