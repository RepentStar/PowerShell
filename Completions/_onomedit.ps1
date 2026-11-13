# PowerShell completion for onomedit
# 生成: onomedit completion pwsh
# 安装: 把下面内容写入 $PROFILE (或单独文件后在 profile 中 . 或 Import)

Register-ArgumentCompleter -Native -CommandName onomedit, onomedit.exe -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    # 已敲入的参数（不含最后一个补全中的词）
    $tokens = $commandAst.CommandElements | ForEach-Object { $_.Extent.Text }
    # 已知子命令；只有完整命中才视为子命令。否则视为第一级补全——CommandElements
    # 会把正在补全的半截词也算作元素，直接取 $tokens[1] 会让一级子命令补全失效。
    $cmds = 'completion config gui help history rename restore version'.Split(' ')
    $cmd = if ($tokens.Count -gt 1 -and $cmds -contains $tokens[1]) { $tokens[1] } else { '' }

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
          '' { $candidates = $cmds }
          'rename' {
              $candidates = '--dry-run','--no-editor','--multi-tab','--reverse','-r','--recursive',
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
