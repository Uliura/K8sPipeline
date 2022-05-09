Connect-AzAccount -UseDeviceAuthentication
New-AzAksCluster -ResourceGroupName $env:RESOURCEGROUPNAME -Name $env:AKSCLUSTERNAME -NodeCount 1 -Location $env:AZURELOCATION -NodeVmSize standard_D2ads_v5 -Force -Confirm:$false
