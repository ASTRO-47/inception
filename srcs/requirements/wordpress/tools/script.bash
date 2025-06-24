#!/bin/bash

# exit on error, but handle specific cases gracefully
set -e

echo "Starting WordPress setup..."

# Wait for MariaDB to be ready
until mysqladmin ping -h mariadb -u root -p"$DB_PASSWORD" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

echo "MariaDB is ready!"

# Download and setup WP-CLI (skip if already exists)
if [ ! -f /usr/local/bin/wp ]; then
    echo "Downloading WP-CLI..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    echo "WP-CLI installed successfully"
else
    echo "WP-CLI already installed, skipping download"
fi

# Download WordPress core (skip if already exists)
if [ ! -f wp-config-sample.php ]; then
    echo "Downloading WordPress core..."
    wp core download --allow-root
else
    echo "WordPress core already exists, skipping download"
fi

# Create wp-config.php (skip if already exists)
if [ ! -f wp-config.php ]; then
    echo "Creating wp-config.php..."
    wp config create --dbname=$DB_NAME --dbuser=root --dbpass=$DB_PASSWORD --dbhost=$DB_HOST --allow-root
else
    echo "wp-config.php already exists, skipping creation"
fi

# Create database (handle if already exists)
echo "Creating WordPress database..."
if wp db create --allow-root 2>/dev/null; then
    echo "Database '$DB_NAME' created successfully"
else
    echo "Database '$DB_NAME' already exists or creation failed, continuing..."
fi

# Install WordPress (check if already installed)
if ! wp core is-installed --allow-root 2>/dev/null; then
    echo "Installing WordPress..."
    wp core install --url=$URL --title=$TITLE --admin_user=$ADMIN_NAME --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root
    echo "WordPress installed successfully"
else
    echo "WordPress is already installed, skipping installation"
fi

# Create additional user (handle if already exists)
echo "Creating user '$USER2_NAME'..."
if wp user get $USER2_NAME --allow-root >/dev/null 2>&1; then
    echo "User '$USER2_NAME' already exists, skipping creation"
else
    wp user create $USER2_NAME $USER2_EMAIL --user_pass=$USER2_PASSWORD --role=author --allow-root
    echo "User '$USER2_NAME' created successfully"
fi

# Install and activate Redis plugin (handle if already installed)
echo "Setting up Redis cache plugin..."
if wp plugin is-installed redis-cache --allow-root; then
    echo "Redis cache plugin already installed"
    if ! wp plugin is-active redis-cache --allow-root; then
        wp plugin activate redis-cache --allow-root
        echo "Redis cache plugin activated"
    else
        echo "Redis cache plugin already active"
    fi
else
    wp plugin install redis-cache --activate --allow-root
    echo "Redis cache plugin installed and activated"
fi

# Configure Redis settings
echo "Configuring Redis settings..."
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PASSWORD $REDIS_PASS --allow-root

# Enable Redis (handle if already enabled)
if wp redis status --allow-root 2>/dev/null | grep -q "Connected"; then
    echo "Redis is already enabled and connected"
else
    echo "Enabling Redis..."
    wp redis enable --allow-root || echo "Redis enable failed, but continuing..."
fi

echo "WordPress setup completed successfully!"

# Start PHP-FPM

echo "Starting PHP-FPM..."
exec php-fpm7.4 -F