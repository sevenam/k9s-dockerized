FROM golang:bullseye

# RUN ["rmdir", "/etc/apt/keyrings"]
RUN ["mkdir", "/etc/apt/keyrings"]

# install packages required to install kubectl and helm
RUN ["apt-get", "update"]
RUN ["apt", "install", "-y", "curl"]
RUN ["apt", "install", "-y", "apt-transport-https"]
RUN ["apt", "install", "-y", "ca-certificates"]
RUN ["apt", "install", "-y", "gpg"]

# Installing kubectl - this has to be updated now and then - see: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.34/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
RUN chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
RUN echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.34/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
RUN chmod 644 /etc/apt/sources.list.d/kubernetes.list

# Installing helm - this has to be updated now and then see https://helm.sh/docs/intro/install/
RUN curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main" | tee /etc/apt/sources.list.d/helm-stable-debian.list

RUN ["apt-get", "update"]
RUN ["apt", "install", "-y", "vim"]
RUN ["apt", "install", "-y", "git"]
RUN ["apt", "install", "-y", "jq"]
RUN ["apt", "install", "-y", "kubectl"]
RUN ["apt", "install", "-y", "helm"]
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash
RUN curl -s https://fluxcd.io/install.sh | FLUX_VERSION=2.0.0 bash

WORKDIR "/root"
RUN ["git", "clone", "https://github.com/derailed/k9s.git"]
WORKDIR "/root/k9s"
RUN ["make", "build"]
WORKDIR "/root/k9s/execs"

RUN ["ln", "-sf", "/bin/bash", "/bin/sh"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]
