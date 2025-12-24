#!/bin/bash

mkdir -p /etc/nginx/ssl
openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/CN=abdelhamid.42.fr"

chmod 755 /var/www/html
chown -R www-data:www-data /var/www/html

exec nginx -g "daemon off;"