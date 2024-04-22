FROM golang:bullseye

# RUN ["rmdir", "/etc/apt/keyrings"]
RUN ["mkdir", "/etc/apt/keyrings"]

# Installing kubectl (this has to be updated now and then - see: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
RUN chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
RUN echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
RUN chmod 644 /etc/apt/sources.list.d/kubernetes.list

# Installing helm - see https://helm.sh/docs/intro/install/
RUN curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null
RUN apt-get install apt-transport-https --yes
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list

RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "vim"]
RUN ["apt-get", "install", "-y", "git"]
RUN ["apt-get", "install", "-y", "jq"]
RUN ["apt-get", "install", "-y", "kubectl"]
RUN ["apt-get", "install", "-y", "helm"]
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash
RUN curl -s https://fluxcd.io/install.sh | FLUX_VERSION=2.0.0 bash

WORKDIR "/root"
RUN ["git", "clone", "https://github.com/derailed/k9s.git"]
WORKDIR "/root/k9s"
RUN ["make", "build"]
WORKDIR "/root/k9s/execs"

RUN ["ln", "-sf", "/bin/bash", "/bin/sh"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]
