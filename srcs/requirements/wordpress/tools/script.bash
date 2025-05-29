#!/bin/bash
until mysqladmin ping -h mariadb -u root -p"$DB_PASSWORD" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar #download the wp-cli.phar file

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp #To use WP-CLI from the command line by typing wp, make the file executable and move it to somewhere in your PATH. Move wp-cli.phar to /usr/local/bin/wp to make it accessible system-wide. This makes the script cleaner and follows standard practices for using CLI tools.

wp core download --allow-root

wp config create --dbname=$DB_NAME --dbuser=root --dbpass=$DB_PASSWORD --dbhost=$DB_HOST --allow-root #Generates and reads the wp-config.php file.

wp db create --allow-root #Create the WordPress database.

wp core install --url=$URL --title=$TITLE --admin_user=$ADMIN_NAME --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root

wp user create $USER2_NAME $USER2_EMAIL --user_pass=$USER2_PASSWORD --role=author --allow-root

exec php-fpm7.4 -F #making this cmd the primary one  (pid 1)

