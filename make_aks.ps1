Get-Credential
$pscredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $env:APPID $env:PASSWORD
Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $env:TENANT
New-AzResourceGroup -Name $(resourcegroupname) -Location $(azurelocation) -Force
New-AzAksCluster -ResourceGroupName $(resourcegroupname) -Name $(aksclustename) -NodeCount 1 -GenerateSshKey -Force
