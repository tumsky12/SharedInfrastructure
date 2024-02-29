$instances = az aks list | ConvertFrom-Json
$activeDevInstances = $instances | Where-Object { $_.tags.Environment.ToLower() -eq "dev" -and $_.powerState.code.toLower() -eq "running" }

$failCount = 0
$activeDevInstances | ForEach-Object {
    Write-Information "Attempting to stop instance $($_.name) in rg $($_.resourceGroup)."
    az aks stop --name $_.name --resource-group $_.resourceGroup
    $instanceDetails = az aks show --name $_.name --resource-group $_.resourceGroup | ConvertFrom-Json
    $isStopped = $instanceDetails.powerState.code.toLower() -eq "stopped"
    $isStopping = $instanceDetails.provisioningState.toLower() -eq "stopping"
    if ($isStopped -or $isStopping) {
        Write-Information "Successfully stopping/stopped instance $($_.name) in rg $($_.resourceGroup)."
    }
    else {
        Write-Error "Failed to stop instance $($_.name) in rg $($_.resourceGroup)."
        $failCount++
    }
}
if ($failCount -gt 0) {
    throw "Failed to stop $($failCount) instances."
}
