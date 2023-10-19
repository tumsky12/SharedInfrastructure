$Command = Get-Item $MyInvocation.MyCommand.Path
$ScriptDirectory = $Command.Directory
. "$($ScriptDirectory)\ScriptUtilities.ps1"

$LogFile = CreateLogFile

# Install Chocolatey 
$Env:ChocolateyVersion = '1.4.0'
"INFO: Installing Chocolatey version $($Env:ChocolateyVersion)" >> $LogFile
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Choco install everything else
choco feature enable -n=allowGlobalConfirmation
"INFO: Installing sublimetext3" >> $LogFile
choco install sublimetext3 6>> $LogFile
"INFO: Installing everything" >> $LogFile
choco install everything 6>> $LogFile
"INFO: Installing microsoft-edge" >> $LogFile
choco install microsoft-edge 6>> $LogFile # alternative -> googlechrome
"INFO: Installing baretail" >> $LogFile
choco install baretail 6>> $LogFile
"INFO: Installing SSMS" >> $LogFile
choco install sql-server-management-studio 6>> $LogFile

choco feature disable -n=allowGlobalConfirmation