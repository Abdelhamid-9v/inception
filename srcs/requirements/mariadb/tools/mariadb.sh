#!/bin/bash

# 1. Initialize if empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

# 2. Start in "Recovery Mode" (No password required)
# This allows us to configure users without getting 'Access Denied'
echo "Starting temporary server..."
# mysqld_safe: The standard command to start the MariaDB server.
#--skip-grant-tables: The Key Flag. It tells MariaDB: "Start up, but disable the authentication system." This allows anyone to log in as root without a password. We need this because we haven't set a password yet!
#--skip-networking: "Don't listen to the outside world." Since we just turned off the security (grant-tables), we block the network port so no hackers can sneak in while we are configuring things.
#& (Ampersand): "Run in the Background."
mysqld_safe --skip-grant-tables --skip-networking &

# Wait for the server to wake up
until mariadb -e "status" &> /dev/null; do
    sleep 1
done

echo "Configuring Database..."

# 3. The Setup Block
# mariadb: Used to edit Data (Select, Insert, Create Users).


# FLUSH PRIVILEGES is required to reload the grant tables after skip-grant-tables
#user@host , % any host or any IP
#GRANT ALL PRIVILEGES :Give this user full power(SELECT (read), INSERT (write), UPDATE (change), DELETE (remove), and even DROP (destroy) tables.)
#The . separates the database name from the table name.
#ALTER...: set a password to the existing root user
mariadb <<EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

echo "Configuration finished. Restarting in safe mode..."

# 4. Stop the temporary server properly
#  [ mysqladmin ]: Used to manage the Server itself (Check health, change passwords, Shutdown).

#-u root :am executing this order as the Boss (Root)
#-p$SQL_ROOT_PASSWORD : Here is the password to prove I am Root

#-p Secret (Password is empty, and it thinks "Secret" is the database name).

#shutdown: Please finish writing any open files to the disk, close all connections, and stop the process.
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# 5. Start the final server (Foreground)
exec mysqld_safe