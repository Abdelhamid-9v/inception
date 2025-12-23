FROM debian:bullseye

# 1. Install wget and tar to download the file
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    && rm -rf /var/lib/apt/lists/*

# 2. Download the Portainer binary (latest version)
# We are NOT pulling a docker image; we are downloading the software manually.
RUN wget https://github.com/portainer/portainer/releases/download/2.19.5/portainer-2.19.5-linux-amd64.tar.gz \
    && tar -xvf portainer-2.19.5-linux-amd64.tar.gz \
    && rm -rf portainer-2.19.5-linux-amd64.tar.gz

# 3. Configure the binary to run
# Portainer stores data in /data, so we create it
RUN mkdir -p /data

# 4. Start Portainer
CMD ["/portainer/portainer"]