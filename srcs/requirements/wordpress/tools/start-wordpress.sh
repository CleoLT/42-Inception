#!/bin/bash

echo "wordpress entrypoint"
set -x

#until mysql -h"$DB_HOSTNAME" -u"$DB_USER_NAME" -p"$DB_USER_PW" -e SELECT 1; do

until mysqladmin ping -h"$DB_HOSTNAME" --silent; do
    sleep 2
done

if [ -f wp-config.php ]; then
    echo "Wordpress already installed"
else
    wp core download --allow-root

    #create wp-config.php
    wp config create \
	--dbname=$DB_NAME \
	--dbuser=$DB_USER_NAME \
	--dbpass=$DB_USER_PW \
	--dbhost=$DB_HOSTNAME \
	--allow-root
	
    #connect to mariadb
    wp core install \
	--path=/var/www/html \
	--url=$DOMAIN_NAME \
	--title="$WP_TITLE" \
	--admin_user=$WP_ADMIN_USER \
	--admin_password=$WP_ADMIN_PW \
	--admin_email=$WP_ADMIN_EMAIL \
	--skip-email \
	--allow-root 

    #add new user
    wp user create $WP_USER_NAME $WP_USER_EMAIL \
	--role=contributor \
	--user_pass=$WP_USER_PW \
	--allow-root
	

fi

exec php-fpm7.4 -F

