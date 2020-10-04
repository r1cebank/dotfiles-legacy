param($Step="A")

function is-admin ()
{
    $user = [security.principal.windowsidentity]::getcurrent()
    $role = new-object security.principal.windowsprincipal $user
    $role.isinrole( [security.principal.windowsbuiltinrole]::administrator )
}
 
if (!(is-admin))
{
    $args = $myinvocation.mycommand.definition
    start-process powershell -ExecutionPolicy Bypass -argumentlist $args -verb 'runas'
    exit
}

# -------------------------------------
# Imports
# -------------------------------------
$script = $myInvocation.MyCommand.Definition
$scriptPath = Split-Path -parent $script
. (Join-Path $scriptpath .\windows\functions.ps1)
$ErrorActionPreference = "Stop"
# Reload the $env object from the registry
function Refresh-Environment {
    $locations = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
    'HKCU:\Environment'

    $locations | ForEach-Object {
        $k = Get-Item $_
        $k.GetValueNames() | ForEach-Object {
            $name = $_
            $value = $k.GetValue($_)
            Set-Item -Path Env:\$name -Value $value
        }
    }

    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}
function which($name) { Get-Command $name -ErrorAction SilentlyContinue | Select-Object Definition }

Clear-Any-Restart

if (Should-Run-Step "A") 
{
    ### Chocolatey
    Write-Host "Installing Chocolatey..." -ForegroundColor "Yellow"
    if ((which cinst) -eq $null) {
        iex (new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')
        Refresh-Environment
        choco feature enable -n=allowGlobalConfirmation
    }

    # ### Install Pinned Applications
    # foreach ($line in Get-Content .\windows\packages\packages.pinned) {
    #     choco install $line --limit-output; <# pin; evergreen #> choco pin add --name $line --limit-output
    # }

    # ### Install Regular Applications
    # foreach ($line in Get-Content .\windows\packages\packages.list) {
    #     choco install $line --limit-output
    # }

    ### Show desktop icons
    Invoke-Expression -Command $scriptPath\windows\settings\ShowIcon.ps1

    ### Disable UAC
    Invoke-Expression -Command $scriptPath\windows\settings\DisableUAC.ps1
	Wait-For-Keypress "The test script will continue after a reboot, press any key to reboot..." 
	Restart-And-Resume $script "B"
}

if (Should-Run-Step "B") 
{
    Read-Host -Prompt "Press Enter to exit"
    ### Install Post Reboot Packages
    choco install wsl-ubuntu-2004 --limit-output
    Wait-For-Keypress "Install script Complete, press any key to exit script..."
}

Read-Host -Prompt "Press Enter to exit"