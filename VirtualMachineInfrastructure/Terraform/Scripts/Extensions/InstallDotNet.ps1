$Command = Get-Item $MyInvocation.MyCommand.Path
$ScriptDirectory = $Command.Directory
. "$($ScriptDirectory)\ScriptUtilities.ps1"

# $LogFile = CreateLogFile -DirectoryName $ScriptDirectory -FileName $ScriptName
$LogFile = CreateLogFile

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor `
    [Net.SecurityProtocolType]::Tls11 -bor `
    [Net.SecurityProtocolType]::Tls

LogToFile -File $LogFile -Message "VeryMuchA Test int int"
LogToFile -File $LogFile -Message ""
LogToFile -File "C:\asdf" -Message "asdfdqwrg"
LogToFile -File $LogFile -Message "Test2"


$Drive = (Get-Location).Drive.Name
$ScriptPath = "$($Drive):\Scripts"
CreateDirectory $ScriptPath
$DotNetInstallDownloadPath = "https://dot.net/v1/dotnet-install.ps1"
$OutFile = "$ScriptPath\dotnet-install.ps1"
"INFO: Downloading $($DotNetInstallDownloadPath) to $($OutFile)" >> $LogFile
Invoke-WebRequest -UseBasicParsing $DotNetInstallDownloadPath -OutFile $OutFile 6>> $LogFile

$InstallDirectory = "$($Drive):\Program Files\dotnet"
CreateDirectory $InstallDirectory

$Channels = @('6.0', '7.0', '8.0')
$Runtimes = @('aspnetcore', 'windowsdesktop' <#,'dotnet'#>)
foreach ($Channel in $Channels) {
    foreach ($Runtime in $Runtimes) {
        "INFO: Installing DotNet runtime $($Runtime) - $($Channel)" >> $LogFile
        & $OutFile -Channel $Channel -Runtime $Runtime -InstallDir $InstallDirectory -Quality 'GA' 6>> $LogFile
    }
}

$Channels = @('6.0', '7.0')
foreach ($Channel in $Channels) {
    foreach ($Runtime in $Runtimes) {
        "INFO: Installing DotNet SDK - $($Channel)" >> $LogFile
        & $OutFile -Channel $Channel -InstallDir $InstallDirectory -Quality 'GA' 6>> $LogFile
    }
}

"INFO: Installing DotNet SDK LTS" >> $LogFile
& $OutFile -Channel "8.0" -InstallDir $InstallDirectory >> $LogFile

"INFO: Setting DotNet environment variables" >> $LogFile
[System.Environment]::SetEnvironmentVariable('DOTNET_ROOT', $InstallDirectory, [System.EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$($InstallDirectory)", [System.EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$($InstallDirectory)\tools", [System.EnvironmentVariableTarget]::Machine)

# Powershell 7
msiexec.exe /package PowerShell-7.3.8-win-x64.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1 USE_MU=1 ENABLE_MU=1 ADD_PATH=1


