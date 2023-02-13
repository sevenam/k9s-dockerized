FROM golang:latest

RUN ["mkdir", "/etc/apt/keyrings"]
RUN ["curl", "-fsSLo", "/etc/apt/keyrings/kubernetes-archive-keyring.gpg", "https://packages.cloud.google.com/apt/doc/apt-key.gpg"]
RUN echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "vim"]
RUN ["apt-get", "install", "-y", "git"]
RUN ["apt-get", "install", "-y", "kubectl"]
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

WORKDIR "/root"
RUN ["git", "clone", "https://github.com/derailed/k9s.git"]
WORKDIR "/root/k9s"
RUN ["make", "build"]
WORKDIR "/root/k9s/execs"

RUN ["ln", "-sf", "/bin/bash", "/bin/sh"]
ENTRYPOINT ["tail", "-f", "/dev/null"]