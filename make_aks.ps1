New-AzAksCluster -ResourceGroupName $(resourcegroupname) -Name $(aksclustename) -NodeCount 1 -Location $(azurelocation)-GenerateSshKey -Force
