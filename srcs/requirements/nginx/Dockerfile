

# Use Debian (penultimate stable is usually safer for Inception)
FROM debian:bullseye
# Sets the OS foundation

# Install NGINX and OpenSSL
RUN apt-get update && apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

# Create the folder for the SSL certificate
RUN mkdir -p /etc/nginx/ssl

# Generate the SSL Certificate (The "Self-Signed" part)
# req -x509: Create a self-signed cert
# -nodes: No password required
# -days 365: Valid for a year
# -subj: Fills in the prompt automatically (Country, State, Locality, Org, Unit, CommonName)

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/CN=abdelhamid.42.fr"

# Copy our custom configuration file into the container
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Permissions (Standard for web folders)
RUN chmod 755 /var/www/html
RUN mkdir -p /var/www/wordpress
RUN chown -R www-data:www-data /var/www/wordpress

# Start NGINX in the foreground (daemon off) so the container doesn't exit immediately
CMD ["nginx", "-g", "daemon off;"]