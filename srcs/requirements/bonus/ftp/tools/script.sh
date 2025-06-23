#!/bin/bash

useradd -m $FTP_USER

echo "$FTP_USER:$FTP_PASS" | chpasswd

mkdir -p /var/www/wordpress

chown $FTP_USER:$FTP_USER /var/www/wordpress # change the ownership of the dire to ftp user and the user group

/usr/sbin/vsftpd /etc/vsftpd.conf