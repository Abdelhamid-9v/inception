#!/bin/bash

cd /var/www/wordpress
#-h :host
echo "Waiting for MariaDB..."
while ! mariadb -h mariadb -u$SQL_USER -p$SQL_PASSWORD $SQL_DATABASE &>/dev/null; do
    sleep 3
done
echo "MariaDB is ready!"

if [ ! -f /usr/local/bin/wp ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

if [ ! -f index.php ]; then
    wp core download --allow-root
fi

if [ ! -f wp-config.php ]; then
    wp config create \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb \
        --allow-root
fi

if ! wp core is-installed --allow-root; then
    wp core install \
        --url=$DOMAIN_NAME \
        --title="$SITE_TITLE" \
        --admin_user=$ADMIN_USER \
        --admin_password=$ADMIN_PASSWORD \
        --admin_email=$ADMIN_EMAIL \
        --allow-root

    wp user create $USER1_LOGIN $USER1_EMAIL --user_pass=$USER1_PASS --role=author --allow-root
    
    
    #  ----
    wp config set WP_REDIS_HOST redis --allow-root
    wp config set WP_REDIS_PORT 6379 --allow-root
    wp plugin install redis-cache --activate --allow-root
    wp redis enable --allow-root
fi

# Start PHP-FPM
exec /usr/sbin/php-fpm7.4 -F