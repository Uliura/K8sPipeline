$pscredential = New-Object -TypeName System.Management.Automation.PSCredential ("7aceb566-5abd-4f7e-8c08-48b1c30f7222",9b2ed638-55b2-4f32-8dc0-c9195df712cf)
Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $env:TENANT
New-AzResourceGroup -Name $(resourcegroupname) -Location $(azurelocation) -Force
New-AzAksCluster -ResourceGroupName $(resourcegroupname) -Name $(aksclustename) -NodeCount 1 -GenerateSshKey -Force
