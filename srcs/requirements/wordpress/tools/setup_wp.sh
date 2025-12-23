#!/bin/bash

cd /var/www/wordpress
#-h :host
echo "Waiting for MariaDB..."
while ! mariadb -h mariadb -u$SQL_USER -p$SQL_PASSWORD $SQL_DATABASE &>/dev/null; do
    sleep 3
done
echo "MariaDB is ready!"

# Download WP-CLI if missing
if [ ! -f /usr/local/bin/wp ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

# Download WordPress Core if missing
if [ ! -f index.php ]; then
#install wordpress php files
    wp core download --allow-root
fi

# Create wp-config.php if missing
if [ ! -f wp-config.php ]; then
    #Before this command runs, your WordPress folder is full of generic PHP files,
    #but it has no identity. It doesn't know who owns it or where to store data.
    wp config create \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb \
        --allow-root
fi

# Check if WordPress is actually installed
if ! wp core is-installed --allow-root; then
    # 1. Install WordPress
    #Creates the WordPress tables in the database using the URL, title, and...
    wp core install \
        --url=$DOMAIN_NAME \
        --title="$SITE_TITLE" \
        --admin_user=$ADMIN_USER \
        --admin_password=$ADMIN_PASSWORD \
        --admin_email=$ADMIN_EMAIL \
        --allow-root

    # 2. Create the second user
    wp user create $USER1_LOGIN $USER1_EMAIL --user_pass=$USER1_PASS --role=author --allow-root

    # 3. BONUS: Configure Redis
    # Set the host to the container name 'redis'
    wp config set WP_REDIS_HOST redis --allow-root
    wp config set WP_REDIS_PORT 6379 --allow-root
    
    # Install and activate the Redis plugin
    wp plugin install redis-cache --activate --allow-root
    
    # Enable the actual caching mechanism
    wp redis enable --allow-root
fi

# Start PHP-FPM
exec /usr/sbin/php-fpm7.4 -F