$AKSName = "xzcluster"
$RGName = "AzureDevOps"
$Nodes = "1"
$AksLocation = "northeurope"
$NodeSize = "standard_D2as_v4"

$AKSCheck = Get-AzAksCluster -Name $AKSName -ResourceGroupName $RGName -ErrorAction SilentlyContinue

if($null -eq $AKSCheck) {
    New-AzAksCluster -ResourceGroupName $RGName -Name $AKSName -NodeCount $Nodes -Location $AksLocation -GenerateSshKey -NodeVmSize $NodeSize -Force
}
else {
    Write-Host "Kubernetes cluster $AKSName already exist"
}
