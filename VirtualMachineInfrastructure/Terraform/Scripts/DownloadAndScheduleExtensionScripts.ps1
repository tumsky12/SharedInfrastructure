param(
    [string] $StorageAccountName,
    [string] $ContainerName,
    [string] $StorageAccountKey
)

$Drive = (get-location).Drive.Name
$DateTimeString = Get-Date -Format "yyyyMMddTHHmmssffffZ"
$ScriptNameWithExtension = $MyInvocation.MyCommand.Name
$Script = Get-Item $ScriptNameWithExtension
$ScriptName = $Script.Basename
$LogFile = "$($Drive):\$($ScriptName).$($DateTimeString).Log"
$TranscriptFile = "$($Drive):\$($ScriptName).$($DateTimeString).Transcript.Log"
Write-Output "ScriptName $ScriptName" 
Write-Output "LogFile $LogFile" 
Start-Transcript -Path $TranscriptFile

try {
    $ScriptPath = "$($Drive):\Scripts"
    if (!(Test-Path -PathType container $ScriptPath)) {
        "INFO: Creating script path: $ScriptPath" >> $LogFile
        New-Item -ItemType Directory -Path $ScriptPath 6>> $LogFile
    }
    
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor `
        [Net.SecurityProtocolType]::Tls11 -bor `
        [Net.SecurityProtocolType]::Tls
     
    "INFO: Installing packages: NuGet" >> $LogFile
    Install-PackageProvider -Name NuGet -Force 6>> $LogFile
    "INFO: Installing packages: Az.Storage" >> $LogFile
    Install-Module Az.Storage -Force 6>> $LogFile
    
    "INFO: Creating storage context" >> $LogFile
    $ConnectionString = "DefaultEndpointsProtocol=https;AccountName=$StorageAccountName;AccountKey=$StorageAccountKey;EndpointSuffix=core.windows.net"
    $Context = New-AzStorageContext -ConnectionString $ConnectionString 6>> $LogFile
    "INFO: Fetching all script blobs" >> $LogFile
    [array]$Blobs = Get-AzStorageBlob -Container $ContainerName -Context $Context -Blob '*.ps1' 6>> $LogFile
    if ($Blobs.Count -gt 0) {
        $Blobs | ForEach-Object {
            "INFO: Fetching & saving blobs: $($_.Name)" >> $LogFile
            $SavePath = "$ScriptPath\$($_.Name)"
            if (Test-Path $SavePath) {
                "INFO: Removing existing script: $SavePath" >> $LogFile
                Remove-Item -Path $SavePath
            }
            Get-AzStorageBlobContent -CloudBlob $_.ICloudBlob -Destination $SavePath -Context $Context -Force 6>> $LogFile
        }

        [array]$Actions = @()
        Get-ChildItem "$ScriptPath\*.ps1" | ForEach-Object {
            if ($_.Name -eq "InstallDotNet.ps1") {
                & $_.FullName 6>> $LogFile
            }
            elseif ($_.Name -ne "ScriptUtilities.ps1") {
                "INFO: Creating schedule action from script: $($_.Name)" >> $LogFile
                $File = "$($ScriptPath)\$($_.Name)"
                $Actions += New-ScheduledTaskAction -Execute "Powershell.exe" -Argument "-file $($File)" -WorkingDirectory $ScriptPath 6>> $LogFile
            }
        }

        if ($Actions.Count -gt 0) {
            "INFO: Creating scheduled task" >> $LogFile
            $CurrentTime = Get-Date
            $TriggerTime = $CurrentTime.AddSeconds(15)
            $Trigger = New-ScheduledTaskTrigger -At $TriggerTime -Once 6>> $LogFile
            $Principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
            Register-ScheduledTask 'ExtensionScripts' -Action $Actions -Trigger $Trigger -Principal $Principal 6>> $LogFile
        }
    }
    else {
        "DEBUG: No script blobs to download" >> $LogFile
    }

}
catch {
    "ERROR: Error af occured: $($Error)" >> "$LogFile"
}
finally {
    Stop-Transcript
}

