# k9s-dockerized

k9s-in-a-container

Just a dockerfile with azure cli, git, vim, kubectl, flux-cli and k9s

Get with:

```bash
docker pull sevenam/k9s-dockerized
```

## howto

```bash
# build the image
docker build -t k9s-dockerized .
# create new container
docker container create -i -t --name k9s k9s-dockerized:latest
# spin up the new container instance
docker container start k9s
# attach to the container
docker attach k9s
# delete the container
docker rm k9s
# start k9s inside the container
./k9s
```

## aks

```bash
# login
az login

# ensure the correct azure subscription has been set
az account set --subscription <guid>
# verify correct account is set
az account show

# list clusters names
az aks list | jq '.[].name'

# list cluster resource groups:
 az aks list | jq '.[].resourceGroup'

# get credentials for cluster
az aks get-credentials --resource-group <resource-group> --name <cluster-name>
```
