#!/bin/bash

apk add jq

az group create --name <myResourceGroup> --location eastus

az keyvault create --name <kvname> \
    --resource-group <myResourceGroup> \
    --enabled-for-deployment true \
    --enabled-for-template-deployment true \
    --location <kvlocation>
az keyvault show 

az ad sp create-for-rbac --skip-assignment | jq -r .appId

acrId=$(az acr show --resource-group <myResourceGroup> --name <acrName> --query "id" --output tsv)

az role assignment create --assignee <appId> --scope $acrId --role Reader

az role assignment create --assignee <appId> --scope <acrId> --role Reader

az aks create \
    --resource-group <myResourceGroup> \
    --name <myAKSCluster> \
    --node-count 1 \
    --service-principal <appId> \
    --client-secret <password> \
    --generate-ssh-keys

az aks install-cli




