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
  --address-prefix 10.0.0.0/8 \
  --subnet-name myAGSubnet \
  --subnet-prefix 10.20.0.0/16

az network vnet subnet create \
  --name myBackendSubnet \
  --resource-group $ResourceGroup \
  --vnet-name $VNetName \
  --address-prefix 10.10.0.0/16

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
--enable-managed-identity -y \
--node-vm-size standard_D2ads_v5 \
--vnet-subnet-id $SUBNETID \
--attach-acr gekaimages 

az aks get-credentials -n $AKSCluster -g $ResourceGroup

NAMESPACE="ingress-basic"
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx --create-namespace --namespace $NAMESPACE -f internal-ingress.yaml

kubectl get svc -n ingress-basic


az network application-gateway create \
  --name $AppGtwName \
  --location $Location \
  --resource-group $ResourceGroup \
  --vnet-name $VNetName \
  --subnet myAGsubnet \
  --sku Standard_v2 \
  --public-ip-address myAGPublicIPAddress 
  --http-settings-cookie-based-affinity Disabled \
  --frontend-port 443 \
  --http-settings-port 80 \
 --http-settings-protocol Http \
  --cert-file ag.pfx \
  --cert-password "password"

az network application-gateway address-pool create \
--gateway-name $AppGtwName \
--resource-group $ResourceGroup \
--name nginx-controller-pool \
--servers 10.10.0.50


az network application-gateway rule update \
--resource-group $ResourceGroup \
--gateway-name $AppGtwName \
--name rule1 \
--address-pool nginx-controller-pool

kubectl apply -f manifest.yaml 



