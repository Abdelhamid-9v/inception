#!/bin/bash

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

echo "Starting temporary server..."
mysqld_safe --skip-grant-tables --skip-networking &
until mariadb -e "status" &> /dev/null; do
    sleep 1
done

echo "Configuring Database..."

mariadb <<eof
FLUSH PRIVILEGES;

CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'localhost';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';

FLUSH PRIVILEGES;
eof

echo "Configuration finished. Restarting in safe mode..."


#   mysqladmin : Used to manage the Server itself (change passwords, Shutdown).
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
exec mysqld_safe