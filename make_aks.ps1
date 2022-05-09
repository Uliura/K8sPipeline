New-AzAksCluster -ResourceGroupName $env:RESOURCEGROUPNAME -Name $env:AKSCLUSTERNAME -NodeCount 1 -Location $env:AZURELOCATION -SshKeyValue '/root/.ssh/id_rsa' -NodeVmSize standard_D2ads_v5 -Force -Debug

