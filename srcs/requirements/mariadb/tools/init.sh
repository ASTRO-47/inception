#!/bin/bash

service mariadb start

# until mysqladmin ping --silent; do
    sleep 4
# done

mysqladmin -u root password $DB_PASSWORD

mysql -e "rename user 'root'@'localhost' to 'root'@'%'" || true

mariadb-admin -u root shutdown

mariadbd-safe --port="3306" --bind="0.0.0.0" --datadir="/var/lib/mysql"