$AKSName = "xzcluster"
$RGName = "AzureDevOps"
$Nodes = "1"
$AksLocation = "eastus"
Install-Module -Name Az -AllowClobber -Force
$AKSCheck = Get-AzAksCluster -Name $AKSName -ResourceGroupName $RGName -ErrorAction SilentlyContinue

if($AKSCheck -eq $null){
    New-AzAksCluster -ResourceGroupName $RGName -Name $AKSName -NodeCount $Nodes -Location $AksLocation -GenerateSshKey -Force

}
else{
    Write-Host "Kubernetes cluster $AKSName already exist"
}
