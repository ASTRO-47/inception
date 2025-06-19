#!/bin/bash

service mariadb start

# until mysqladmin ping --silent >/dev/null 2>&1; do
    sleep 4
# done

mysqladmin -u root password $DB_PASSWORD 2>/dev/null

mysql -e "rename user 'root'@'localhost' to 'root'@'%'" 2>/dev/null

mariadb-admin -u root shutdown

mariadbd-safe --port="3306" --bind="0.0.0.0" --datadir="/var/lib/mysql"