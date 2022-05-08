Connect-AzAccount
New-AzResourceGroup -Name $env:resourcegroupname -Location $env:azurelocation -Force
New-AzAksCluster -ResourceGroupName $env:resourcegroupname -Name $env:aksclustename -NodeCount 1 -GenerateSshKey -Force
