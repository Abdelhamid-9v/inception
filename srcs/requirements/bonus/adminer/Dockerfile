FROM debian:bullseye

# 1. Install PHP and wget (to download the file)
RUN apt-get update && apt-get install -y \
    php \
    php-mysql \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 2. Move to the folder where we will serve the site
WORKDIR /var/www/html

# 3. Download the Adminer file and rename it to 'index.php'
# (We rename it so the server opens it automatically)
RUN wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php" -O index.php

# 4. Start the built-in PHP web server
# Listen on 0.0.0.0 (all IPs) at port 8080
#-S server mode stay alive
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]