# PowerShell completion for onomedit
# 生成: onomedit completion pwsh
# 安装: 把下面内容写入 $PROFILE (或单独文件后在 profile 中 . 或 Import)

Register-ArgumentCompleter -Native -CommandName onomedit, onomedit.exe -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    # 已敲入的参数（不含最后一个补全中的词）
    $tokens = $commandAst.CommandElements | ForEach-Object { $_.Extent.Text }
    $cmd = if ($tokens.Count -gt 1) { $tokens[1] } else { "" }

    # 值型选项的取值
    $valueMap = @{
        '--path-type' = 'full','name','stem','ext'
        '--sort-by'   = 'default','name','path','mtime','ctime','size'
        '--exclude'   = 'f','file','d','dir','l','link','r','readonly','h','hidden','s','system'
    }

          # 当前补全目标前一个参数（用于值型选项）
      $last = $tokens[$tokens.Count - 1]
      if ($valueMap.ContainsKey($last)) {
          $valueMap[$last] | Where-Object { $_ -like "$wordToComplete*" } |
              ForEach-Object { [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_) }
          return
      }
  
      $candidates = @()
      switch ($cmd) {
          '' { $candidates = 'completion config gui help history rename restore version'.Split(' ') }
          'rename' {
              $candidates = '--dry-run','--no-editor','--multi-tab','--reverse',
                  '--timeout','--depth','--sort-by','--exclude','--path-type'
          }
          'restore' { $candidates = '--all','--partial' }
          'history' { $candidates = '--all' }
          'config'  { $candidates = 'set','set-editor','reset' }
          'completion' { $candidates = 'bash','zsh','pwsh','fish','psc' }
          'help'    { $candidates = 'completion config gui help history rename restore version'.Split(' ') }
          default   { $candidates = @() }
      }
  
      $candidates | Where-Object { $_ -like "$wordToComplete*" } |
          ForEach-Object { [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_) }
}
