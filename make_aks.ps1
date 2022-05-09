$VerbosePreference="Continue"
New-AzAksCluster -ResourceGroupName $env:RESOURCEGROUPNAME -Name $env:AKSCLUSTERNAME -NodeCount 1 -Location $env:AZURELOCATION -GenerateSshKey -NodeVmSize standard_D2ads_v5 -Force

