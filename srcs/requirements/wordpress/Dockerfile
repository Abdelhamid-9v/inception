FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php7.4-fpm \ 
    php7.4-mysql \
    mariadb-client \
    php-redis \
    curl \
    && rm -rf /var/lib/apt/lists/*


#by default, PHP-FPM listens on a "socket" (a file)
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf
RUN mkdir -p /run/php

COPY tools/setup_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup_wp.sh

WORKDIR /var/www/wordpress

ENTRYPOINT ["/usr/local/bin/setup_wp.sh"]