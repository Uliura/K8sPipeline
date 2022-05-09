New-AzAksCluster -ResourceGroupName $env:resourcegroupname -Name $env:aksclustename -NodeCount 1 -GenerateSshKey -Force
