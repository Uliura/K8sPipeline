Write-Host "$tenant"
Write-Host "$appid"
Write-Host "$secretId"
$pscredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $AppId, $secretId
Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $tenant
New-AzResourceGroup -Name $(resourcegroupname) -Location $(azurelocation) -Force
New-AzAksCluster -ResourceGroupName $(resourcegroupname) -Name $(aksclustename) -NodeCount 1 -GenerateSshKey -Force
