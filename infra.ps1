$AKSName = "xzcluster"
$ResourceGroupName = "AzureDevOps"
$Nodes = "1"
$AksLocation = "eastus"

$AKSName = 'Get-AzAksCluster -Name $AKSName -ResourceGroupName $ResourceGroupName -ErrorAction SilentlyContinue'

if($AKSName -eq $null){
    New-AzAksCluster -ResourceGroupName $ResourceGroupName -Name $AKSName -NodeCount $Nodes -Location $AksLocation -GenerateSshKey -SshKeyValue $env:System.DefaultWorkingDirectory -Force

}
else{
    Write-Host "Kubernetes cluster $AKSName already exist"
}