#!/bin/bash

if [ ! -f "/etc/vsftpd.userlist" ]; then

    echo "Setting up FTP user..."
    # shell (we give /bin/bash so they can log in)
    adduser $FTP_USER --disabled-password --gecos "" --home /var/www/wordpress --shell /bin/bash
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
    echo "$FTP_USER" >> /etc/vsftpd.userlist
    chown -R $FTP_USER:$FTP_USER /var/www/wordpress
    chmod -R 755 /var/www/wordpress

    echo "FTP User '$FTP_USER' created!"
fi
echo "Starting vsftpd..."
/usr/sbin/vsftpd /etc/vsftpd.conf