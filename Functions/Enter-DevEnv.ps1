function Enter-DevEnv {
    $vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
    if (-not (Test-Path $vswhere)) {
        Write-Warning "Visual Studio Installer not found. Skipping dev env setup."
        return
    }
    $vsPath = & $vswhere -latest -products * -property installationPath
    if (-not $vsPath) {
        Write-Warning "No Visual Studio installation found."
        return
    }
    $devShellDll = Join-Path $vsPath "Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
    if (-not (Test-Path $devShellDll)) {
        Write-Warning "DevShell DLL not found at: $devShellDll"
        return
    }
    Import-Module $devShellDll
    Enter-VsDevShell -VsInstallPath $vsPath -SkipAutomaticLocation -DevCmdArguments "-arch=x64 -host_arch=x64"
    Write-Host "MSVC dev environment loaded from $vsPath (x64)" -ForegroundColor Green
}
