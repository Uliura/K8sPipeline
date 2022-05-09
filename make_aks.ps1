New-AzAksCluster -ResourceGroupName $env:RESOURCEGROUPNAME -Name $env:AKSCLUSTERNAME -NodeCount 1 -Location $env:AZURELOCATION -GenerateSshKey -Force
