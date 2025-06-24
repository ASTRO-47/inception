#!/bin/bash

useradd -d /var/www/wordpress $FTP_USER

echo "$FTP_USER:$FTP_PASS" | chpasswd

echo "$FTP_USER" >> /etc/vsftpd.userlist

mkdir -p /var/www/wordpress

mkdir -p /var/run/vsftpd/empty #dummy root  for user jail

chown -R $FTP_USER:$FTP_USER    /var/www/wordpress

chmod 755 /var/www/wordpress

vsftpd /etc/vsftpd.conf