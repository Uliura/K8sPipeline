#!/bin/bash
ResourceGroup="Pipeline"
AKSCluster="xzklaster"
VNetName="myVNet"
AppGtwName="GekaApplicationGateway"
Location="northeurope"

az group create --name $ResourceGroup --location northeurope

az network vnet create \
  --name $VNetName \
  --resource-group $ResourceGroup \
  --location $Location \
  --address-prefix 10.0.0.0/16 \
  --subnet-name myAGSubnet \
  --subnet-prefix 10.0.1.0/24

az network vnet subnet create \
  --name myBackendSubnet \
  --resource-group $ResourceGroup \
  --vnet-name $VNetName \
  --address-prefix 10.0.2.0/24

az network public-ip create \
  --resource-group $ResourceGroup \
  --name myAGPublicIPAddress \
  --allocation-method Static \
  --sku Standard \
  --location northeurope

SUBNETID=$(az network vnet subnet list --resource-group $ResourceGroup --vnet-name $VNetName --query "[?name=='myBackendSubnet'].id" --output tsv)

az aks create \
--resource-group $ResourceGroup \
--name $AKSCluster \
--node-count 1 \
--no-ssh-key \
--node-vm-size standard_D2ads_v5 \
--network-plugin azure \
--enable-managed-identity -y \
--service-cidr 10.0.3.0/24 \
--dns-service-ip 10.0.3.10 \
--vnet-subnet-id $SUBNETID \
--attach-acr gekaimages 



az network application-gateway create \
  --name $AppGtwName \
  --location $Location \
  --resource-group $ResourceGroup \
  --vnet-name $VNetName \
  --subnet myAGsubnet \
  --sku Standard_v2 \
  --http-settings-cookie-based-affinity Disabled \
  --frontend-port 443 \
  --http-settings-port 80 \
  --http-settings-protocol Http \
  --public-ip-address myAGPublicIPAddress \
  --cert-file ag.pfx \
  --cert-password "password"

appgwId=$(az network application-gateway show -n $AppGtwName -g $ResourceGroup -o tsv --query "id") 
az aks enable-addons -n $AKSCluster -g $ResourceGroup -a ingress-appgw --appgw-id $appgwId


