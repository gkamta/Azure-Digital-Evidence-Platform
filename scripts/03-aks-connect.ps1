Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$resourceGroup = Read-Host "Resource group"
$aksName = Read-Host "AKS cluster name"

az aks get-credentials --resource-group $resourceGroup --name $aksName --overwrite-existing

kubectl get nodes
kubectl get pods -A
