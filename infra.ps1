Write-Host "$AKSName, $RGName, $Nodes , $AksLocation"

$AKSName = Get-AzAksCluster -Name $AKSName -ResourceGroupName $RGName -ErrorAction SilentlyContinue

if($AKSName -eq $null){
    New-AzAksCluster -ResourceGroupName $RGName -Name $AKSName -NodeCount $Nodes -Location $AksLocation -GenerateSshKey -SshKeyValue $env:System.WorkFolder -Force

}
else{
    Write-Host "Kubernetes cluster $AKSName already exist"
}