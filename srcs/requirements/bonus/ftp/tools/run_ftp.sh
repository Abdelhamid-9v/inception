#!/bin/bash

# 1. Check if the user already exists (to avoid errors on restart)
if [ ! -f "/etc/vsftpd.userlist" ]; then

    echo "Setting up FTP user..."

    # Create the user, pointing their home to the WordPress folder
    # -d = Home Directory
    # -s = Shell (we give /bin/bash so they can log in)
    adduser $FTP_USER --disabled-password --gecos "" --home /var/www/wordpress --shell /bin/bash

    # Set the password using the variable from .env
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

    # Add the user to the allowed list
    echo "$FTP_USER" >> /etc/vsftpd.userlist

    # Fix permissions so the user owns the folder
    chown -R $FTP_USER:$FTP_USER /var/www/wordpress
    chmod -R 755 /var/www/wordpress

    echo "FTP User '$FTP_USER' created!"
fi
mkdir -p /var/run/vsftpd/empty
# 2. Start the FTP server in the foreground
echo "Starting vsftpd..."
/usr/sbin/vsftpd /etc/vsftpd.conf