FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    wget \
    tar \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/portainer/portainer/releases/download/2.19.5/portainer-2.19.5-linux-amd64.tar.gz \
    && tar -xvf portainer-2.19.5-linux-amd64.tar.gz \
    && rm -rf portainer-2.19.5-linux-amd64.tar.gz

# portainer stores data in /data
RUN mkdir -p /data
CMD ["/portainer/portainer"]