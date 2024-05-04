FROM ubuntu:noble-20240429

ENV YQ="4.29.2"
ENV KUBECTL="1.30.0"

# install packages
RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  bind9-dnsutils \
  iputils-ping \
  jq \
  git \
  nmap \
  openssh-client \
  tree \
  vim-tiny \
  wget \
  software-properties-common
  
RUN add-apt-repository ppa:fish-shell/release-3 && apt-get update && apt-get install -y --no-install-recommends fish && rm -rf /var/lib/apt/lists/*

# Config ca-certificates for wget
RUN echo "ca_certificate=/etc/ssl/certs/ca-certificates.crt" > $HOME/.wgetrc

# kubectl
RUN curl -L https://dl.k8s.io/release/v${KUBECTL}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
  chmod +x /usr/local/bin/kubectl

# yq
RUN wget https://github.com/mikefarah/yq/releases/download/v${YQ}/yq_linux_amd64 -O /usr/local/bin/yq && \
  chmod +x /usr/local/bin/yq

# RUN echo `export PS1="\e[0;32m[\u@\h \W]\$ \e[m "` >> /root/.profile 
# && echo export PS1="\e[0;32m[\u@\h \W]\$ \e[m " >> /root/.bashrc

