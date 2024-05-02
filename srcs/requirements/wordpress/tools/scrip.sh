#!/bin/bash

# Download wp cli
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp
chmod +x /usr/local/bin/wp

# Download and extract WordPress
mkdir -p /var/www/html/wordpress
chmod 777 /var/www/html/wordpress

# Download WordPress
wp core download --path=/var/www/html/wordpress --allow-root

# Create wp-config
wp config create --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --dbpass=$MYSQL_PASSWORD \
    --dbhost=$MYSQL_HOST \
    --path=/var/www/html/wordpress \
    --allow-root

# Install WordPress
wp core install --allow-root --path=/var/www/html/wordpress \
    --url=$WP_URL \
    --title=$WP_TITLE  \
    --admin_user=$WP_ADMIN \
    --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL

# Change ownership of WordPress files

chown -R www-data:www-data /var/www/html/wordpress

php-fpm -F