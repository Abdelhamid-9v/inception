#!/bin/bash

mkdir -p /etc/nginx/ssl
openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/CN=abel-had.42.fr"

chmod 755 /var/www/html
chown -R www-data:www-data /var/www/html

# We use 'exec' so NGINX replaces this script as PID 1
exec nginx -g "daemon off;"