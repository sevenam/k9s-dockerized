# k9s-dockerized
k9s-in-a-container

Just a dockerfile with azure cli, git, vim and k9s


## howto

```bash
# build the image
docker build -t k9s-dockerized .
# run the container
docker run --name k9s k9s-dockerized:latest
# start k9s inside the container
./k9s
```

## misc

```bash
# create new container
docker container create -i -t --name k9s k9s-dockerized:latest
# spin up the new container instance
 docker container start k9s
```



