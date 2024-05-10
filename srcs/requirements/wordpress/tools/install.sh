#!/bin/bash

mkdir -p /var/www/html/wordpress

# Change ownership of WordPress files
chown -R www-data:www-data /var/www/html/wordpress

# Download wp-cli directly into the user's bin directory
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp
chmod +x /usr/local/bin/wp

wp --allow-root core download --path=/var/www/html/wordpress

# Configure WordPress
mv /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
wp config set DB_NAME $MYSQL_DATABASE --allow-root --path=/var/www/html/wordpress
wp config set DB_USER $MYSQL_USER --allow-root --path=/var/www/html/wordpress
wp config set DB_PASSWORD $MYSQL_PASSWORD --allow-root --path=/var/www/html/wordpress
wp config set DB_HOST mariadb --allow-root --path=/var/www/html/wordpress

wp --allow-root core install --path=/var/www/html/wordpress \
    --url="$WP_URL" \
    --title="$WP_TITLE" \
    --admin_user=$WP_ADMIN \
    --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL


wp --allow-root user create $WP_USER $WP_EMAIL --user_pass="$WP_PASSWORD" --path=/var/www/html/wordpress

sed -i 's#listen = /run/php/php7.4-fpm.sock#listen = 0.0.0.0:9000#g' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's#chdir = /var/www#chdir = /var/www/html/wordpress#g' /etc/php/7.4/fpm/pool.d/www.conf

php-fpm7.4 -F