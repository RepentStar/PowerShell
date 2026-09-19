# 克隆(pwsh)

git clone https://github.com/RepentStar/PowerShell.git "$HOME\Documents\PowerShell"

# 安装模块

```powershell
Install-Module -Name PSReadLine
Install-Module -Name CompletionPredictor
Install-Module -Name Terminal-Icons
Install-Module -Name PSCompletions
Install-Module -Name PSFzf
```

# 依赖外部程序

fd fzf zoxide ...

# 自适应 `ls` 显示

`ls` 会先统计结果数量：不超过 20 项时使用详细表格，超过 20 项时使用紧凑的多列显示。
原生 `Get-ChildItem` 不受影响，仍可安全地把对象传入管道。

可以在配置中修改切换阈值：

```powershell
$global:AdaptiveLsCompactThreshold = 30
```
