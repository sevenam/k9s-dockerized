# k9s-dockerized
k9s-in-a-container

Just a dockerfile with azure cli, git, vim and k9s


# howto

```bash
## build the image
docker build -t k9s-dockerized .
# run the container
docker run --name k9s k9s-dockerized:latest
```