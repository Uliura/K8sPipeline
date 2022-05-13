$AKSName = "xzcluster"
$RGName = "AzureDevOps"
$Nodes = "1"
$AksLocation = "eastus"

$AKSCheck = Get-AzAksCluster -Name $AKSName -ResourceGroupName $RGName -ErrorAction SilentlyContinue

if($AKSCheck -eq $null){
    New-AzAksCluster -ResourceGroupName $RGName -Name $AKSName -NodeCount $Nodes -Location $AksLocation -SshKeyValue $env:System.WorkFolder -Force

}
else{
    Write-Host "Kubernetes cluster $AKSName already exist"
}