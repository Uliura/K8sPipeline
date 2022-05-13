$AKSName = "xzcluster"
$RGName = "AzureDevOps"
$Nodes = "1"
$AksLocation = "eastus"

$AKSCheck = Get-AzAksCluster -Name $AKSName -ResourceGroupName $RGName -ErrorAction SilentlyContinue
Write-Host "Check = $AKSCheck"
if($null -eq $AKSCheck){
    New-AzAksCluster -ResourceGroupName $RGName -Name $AKSName -NodeCount $Nodes -Location $AksLocation -GenerateSshKey -NodeVmSize -Force
    Write-Host "Error occurred: $_"
}
else{
    Write-Host "Kubernetes cluster $AKSName already exist"
}
