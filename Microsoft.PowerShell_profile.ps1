# Keep PowerShell and native tools (notably fd/fzf used by PSFzf) on the same encoding. Windows may otherwise start the console on code page 936, which causes UTF-8 Chinese file names to be decoded as garbled text.
$utf8NoBom = [System.Text.UTF8Encoding]::new($false)
[Console]::InputEncoding = $utf8NoBom
[Console]::OutputEncoding = $utf8NoBom
$global:OutputEncoding = $utf8NoBom

# Remove build in Alias
@(
    'rm', 'rmdir', 'mv', 'cp', 'cat', 'curl', 'wget',
    'diff', 'sort', 'tee', 'echo', 'sleep', 'where'
) | ForEach-Object {
    if (Get-Alias $_ -ErrorAction SilentlyContinue) {
        Remove-Alias $_ -Force -ErrorAction SilentlyContinue
    }
}

# Alias
Set-Alias nv nvim -Force -Option AllScope

# zsh-style parent-directory shortcuts
function ..   { Set-Location .. }
function ...  { Set-Location ../.. }
function .... { Set-Location ../../.. }

# starship
Invoke-Expression (&starship init powershell)

# zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# auto suggestions
Import-Module PSReadLine
Import-Module CompletionPredictor

# Custom Module
Import-Module Terminal-Icons
Import-Module PSFzf

# Option
Set-PSReadLineOption -PredictionViewStyle ListView -BellStyle None -EditMode Windows
Set-PSReadLineKeyHandler -Key 'Ctrl+z' -Function Undo
Set-PSReadLineOption -Colors @{
    Parameter       = '#98FB98'
}

# 开启 Ctrl+T（路径）和 Ctrl+R（历史）
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# Import after setting EditMode because Set-PSReadLineOption resets key bindings.
Import-Module PSCompletions
if ($PSCompletions.guid) {
    $psCompletionsTriggerKey = if ($PSCompletions.config.trigger_key) {
        $PSCompletions.config.trigger_key
    } else {
        $PSCompletions.trigger_key
    }
    Set-PSReadLineKeyHandler -Key $psCompletionsTriggerKey `
        -ScriptBlock $PSCompletions.menu.module_completion_menu_script
}

# 用 fd 生成递归文件列表：更快，自动尊重 .gitignore、跳过 .git
$env:FZF_CTRL_T_COMMAND = 'fd --type f --hidden --follow --exclude .git'

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
