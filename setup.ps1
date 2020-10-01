$downloadDest = [System.IO.Path]::GetTempFileName()
$extractDest = [System.IO.Path]::GetTempPath()
### Download the archive
(New-Object Net.WebClient).DownloadFile("https://github.com/r1cebank/dotfiles/archive/master.zip", "$downloadDest.zip")
Expand-Archive -LiteralPath "$downloadDest.zip" -DestinationPath $extractDest

### Run the installation
Invoke-Expression -Command $extractDest\dotfiles-master\installer.ps1