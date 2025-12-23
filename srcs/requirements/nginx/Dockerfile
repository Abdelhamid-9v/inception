FROM debian:bullseye

# 1. Install NGINX and OpenSSL (Required for the script to work)
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# 2. Copy the config file (This MUST be done here, not in the script)
COPY conf/nginx.conf /etc/nginx/nginx.conf

# 3. Copy the setup script we just wrote
COPY tools/nginx.sh /usr/local/bin/nginx.sh

# 4. Make the script executable
RUN chmod +x /usr/local/bin/nginx.sh

# 5. Create necessary folder for NGINX socket
# RUN mkdir -p /var/run/nginx

ENTRYPOINT ["/usr/local/bin/nginx.sh"]