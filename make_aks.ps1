$secPassword = ConvertTo-SecureString $env:servicePrincipalKey -AsPlainText -Force
$Credential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $env:servicePrincipalId,$secPassword
Connect-AzAccount -Credential $Credential -Tenant $env:tenantId
New-AzAksCluster -ResourceGroupName $env:RESOURCEGROUPNAME -Name $env:AKSCLUSTERNAME -NodeCount 1 -Location $env:AZURELOCATION -SshKeyValue '/root/.ssh/id_rsa' -NodeVmSize standard_D2ads_v5 -Force -Confirm:$false
