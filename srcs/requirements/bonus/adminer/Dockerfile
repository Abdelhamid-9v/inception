FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php \
    php-mysql \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html
RUN wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php" -O index.php

#-S server mode stay alive
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]