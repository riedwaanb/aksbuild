resourcegroup="AKS-Scaleconf"
regname="ACRegistryZA"
clustername="AKSClusterZA"

echo Resource Group $resourcegroup
echo Container Registry name $regname
echo Cluster Name $clustername

test=$(az group show -g $resourcegroup --output tsv)
#test="[]"
echo Found $test

#if no resource group was found, build it
if [ -z "$test" ]
then
  echo Creating Resource Group $resourcegroup
  az group create -g $resourcegroup -l westeurope
  echo Building a container registry
  az acr create --resource-group $resourcegroup --name $regname --sku Basic

  echo Building AKS Cluster $clustername
  az aks create --resource-group $resourcegroup --name $clustername --node-count 1 --generate-ssh-keys
  az aks get-credentials --resource-group $resourcegroup --name $clustername
  kubectl get nodes
  aksid=$(az aks show --resource-group $resourcegroup --name $clustername --query "servicePrincipalProfile.clientId" --output tsv)
  acrid=$(az acr show --name $regname --resource-group $resourcegroup --query "id" --output tsv)
  echo Doing role assignment $aksid --- $acrid
  az role assignment create --assignee $aksid --role Reader --scope $acrid

else
  echo Existing Cluster found, no need to build it
fi
