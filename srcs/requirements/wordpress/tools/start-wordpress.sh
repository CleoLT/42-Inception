#!/bin/bash

echo "wordpress entrypoint"

until mysql -h$DB_NAME -u$DB_USER_NAME -p$DB_USER_PW -e SELECT 1; do
    sleep 1
done

if [-f wp-config.php]; then
    echo "Wordpress already installed"
else
    wp core download --allow-

    wp config create \ #create wp-config.php
	--dbname=$DB_NAME \
	--dbuser=$DB_USER_NAME \
	--dbpass=$DB_USER_PW \
	--dbhost=$DB_HOSTNAME \
	--allow-root
		
    wp core install \ #connect to mariadb
	--path=/var/www/html \
	--url="http://localhost" \
	--title="Mi WordPress" \
	--admin_user=$WP_ADMIN_USER \
	--admin_password=$WP_ADMIN_PW \
	--admin_email=$WP_ADMIN_EMAIL \
	--skip-email \
	--allow-root

exec php-fpm -F
