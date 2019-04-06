# AKS Rapid Cluster builds
These shell scripts are used to quickly build an Container Registry, Key Vault, service principle, AKS cluster - and remove them just as quickly. Perfect for building and destroying a cluster for testing and demos. 

## Usage
- Edit the ````settings.json```` file to match the settings your require. 
- For security reasons **DO NOT** use the default settings provided.
- To build a cluster execute ````aks_deploy```` by either making it executable or with a ````sh aks_deploy```` command.
- To remove a cluster that was previously deployed execute ````aks_remove```` similarly.

## The ````aks_deploy```` script will build
1. Azure Container Registry
2. Azure Key Vault
3. Azure AD Service Principle
>The Service Principle ID is stored in the Azure Key Vault as the key ````spID```` and the Service Principle password is stored as the key ````spPW````. The ````spID```` will be used to remove the Service Principle using the ````aks_remove```` script. This Sevice Principle is used to give the right access to the AKS cluster and the Container Registry.
4. Azure Kubernetes Cluster

## The ````aks_remove```` script will remove
1. The AD Service Principle
>The Service Principle ID is retrieved from the Key Vault we deployed.
2. The Resource Group containing everything we previously deployed.

