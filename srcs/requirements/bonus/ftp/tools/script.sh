#!/bin/sh

mkdir -p /var/www/wordpress

useradd -d /var/www/wordpress $FTP_USER

echo "$FTP_USER:$FTP_PASS" | chpasswd

echo "$FTP_USER" >> /etc/vsftpd.userlist

mkdir -p /var/run/vsftpd/empty #dummy root dire

chown -R $FTP_USER:$FTP_USER    /var/www/wordpress

chmod 755 /var/www/wordpress

vsftpd /etc/vsftpd.conf
