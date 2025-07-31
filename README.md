# k9s-dockerized

k9s-in-a-container

Just a dockerfile with azure cli, git, vim, kubectl, flux-cli and k9s

Docker Hub:

```bash
## get
docker pull sevenam/k9s-dockerized
## create new container
docker container create -i -t --name k9s sevenam/k9s-dockerized:latest
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

## upgrading and keeping the config

```bash
# start the container
sudo docker container start k9s
# copy the config from the container
sudo docker cp k9s:/root/.kube/config ./config-backup
# stop the container
sudo docker container stop k9s
# delete the container
sudo docker container rm k9s
# pull the new image
sudo docker pull sevenam/k9s-dockerized
# create the new container
sudo docker container create -i -t --name k9s sevenam/k9s-dockerized:latest
# start the container
sudo docker container start k9s
# attach to the container
sudo docker container attach k9s
# create the .kube folder inside the container
mkdir /root/.kube
# copy the config to the new container
sudo docker cp ./config-backup k9s:/root/.kube/config
```
