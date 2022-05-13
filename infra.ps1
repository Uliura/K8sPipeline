$AKSName = xzcluster
$ResourceGroupName = AzureDevOps
$Nodes = 1
$AksLocation = eastus

$AKSName = Get-AzAksCluster -Name $AKSName -ResourceGroupName $ResourceGroupName -ErrorAction SilentlyContinue

if($AKSName -eq $null){
    Write-Host "Kubernetes cluster $AKSName not exist"

}
else{
    Write-Host "Kubernetes cluster $AKSName already exist"
}