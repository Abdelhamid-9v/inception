FROM debian:bullseye

# Install PHP and extensions + CURL (New!)
RUN apt-get update && apt-get install -y \
    #The PHP processor that runs WordPress.
    php7.4-fpm \ 
    #Allows PHP to talk to your database.
    php7.4-mysql \
    #This installs the mariadb command-line tool, which your script uses to check if the database is ready.
    mariadb-client \
    php-redis \
    #Used to download the WP-CLI tool.
    curl \
    && rm -rf /var/lib/apt/lists/*

# (Keep the rest of your file the same: listen 9000 fix, mkdir, etc.)
#Network Fix: By default, PHP-FPM listens on a "socket" (a file). NGINX (in a different container) cannot read a file inside this container. This command forces PHP to listen on Port 9000 so NGINX can send requests over the network.
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf
RUN mkdir -p /run/php

COPY tools/setup_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup_wp.sh

WORKDIR /var/www/wordpress

ENTRYPOINT ["/usr/local/bin/setup_wp.sh"]