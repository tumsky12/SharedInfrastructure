$downgradeSKU = "Standard_B1ms"
$ignoreSKUs = "Standard_B1ls", "Standard_B1s", $downgradeSKU

$instances = az aks list | ConvertFrom-Json
[array]$activeDevInstances = $instances | Where-Object { $_.tags.Environment.ToLower() -eq "dev" }
$allVmsss = az vmss list | ConvertFrom-Json
[array]$systemVMScaleSets = $allVmsss | Where-Object { $_.tags."aks-managed-poolName".ToLower() -in ("system", "default") -and $_sku.name -ne $downgradeSKU }


foreach ($instance in $activeDevInstances) {
    $nodeResourceGroup = $instance.nodeResourceGroup
    [array]$instanceVMScaleSets = $systemVMScaleSets | Where-Object { $_.resourceGroup -eq $nodeResourceGroup }
    foreach ($scaleSet in $instanceVMScaleSets) {
        $scaleSetSku = $scaleSet.sku.name
        if ($scaleSetSku -notin $ignoreSKUs) {
            Write-Output "Attempting to downgrade $($scaleSet.name) rg $($scaleSet.resourceGroup) to $($downgradeSKU)."
            az vmss update --name $scaleSet.name --resource-group $scaleSet.resourceGroup --vm-sku $downgradeSKU
            $details = az vmss show --name $scaleSet.name --resource-group $scaleSet.resourceGroup | ConvertFrom-Json
            $isDowngraded = $details.sku.name -eq $downgradeSKU
            if ($isDowngraded) {
                Write-Output "Successfully downgradede $($scaleSet.name) rg $($scaleSet.resourceGroup) to $($downgradeSKU)."
            }
            else {
                Write-Error "Failed to downgradede $($scaleSet.name) rg $($scaleSet.resourceGroup) to $($downgradeSKU)."
                $failCount++
            }
        }
    }
}
if ($failCount -gt 0) {
    throw "Failed to stop $($failCount) instances."
}
