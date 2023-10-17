function CreateLogFile {
    $Script = Get-Item $MyInvocation.ScriptName
    $ScriptDirectory = $Script.DirectoryName
    $ScriptName = $Script.BaseName
    $DateTimeString = Get-Date -Format "yyyyMMddTHHmmssffffZ"
    $LogFileName = "$($ScriptDirectory)\$($ScriptName).$($DateTimeString).Log"	
    $null = New-Item -ItemType File -Path $LogFileName
    return $LogFileName
}

function CreateDirectory {
    param (
        [string] $DirectoryName
    )
    if (!(test-path -PathType container $DirectoryName)) {
        New-Item -ItemType Directory -Path $DirectoryName
    } 
}

# function LogToFile {
#     param (
#         [string] $Level = "INFO",
#         [string] $File,
#         [string] $Message
#     )
#     if ((Test-Path $File) -and $Message) {
#         $Level = $Level.ToUpper()
#         $DateTimeString = Get-Date -Format "yyyyMMddTHHmmssffffZ"
#         $LogMessage = "$($DateTimeString) $($Level): $($Message)"
#         $LogMessage >> $File
#     }
# }