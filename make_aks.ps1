Write-Host "$tenant"
Write-Host "$appid"
Write-Host "$secretId"
#$pscredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $SP.AppId, $SP.secretId
#Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $SP.tenant
#New-AzResourceGroup -Name $(resourcegroupname) -Location $(azurelocation) -Force
#New-AzAksCluster -ResourceGroupName $(resourcegroupname) -Name $(aksclustename) -NodeCount 1 -GenerateSshKey -Force
