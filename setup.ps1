### Install PowerShell Modules
Write-Host "Installing PowerShell Modules..." -ForegroundColor "Yellow"
Install-Module Posh-Git -Scope CurrentUser -Force
Install-Module PSWindowsUpdate -Scope CurrentUser -Force

### Download the archive
(New-Object Net.WebClient).DownloadFile("https://github.com/r1cebank/dotfiles/archive/master.zip", "$env:temp\dotfiles.zip")
Expand-Archive -LiteralPath $env:temp\dotfiles.zip -DestinationPath $env:temp\dotfiles

### Run the installation
Invoke-Expression -Command $env:temp\dotfiles\dotfiles-master\setup.ps1