# Modify www.conf so that it works locally as it's asked
target="/etc/php7/php-fpm.d/www.conf"

# The www.conf file is needed for communication with the server
grep -E "listen = 127.0.0.1" $target > /dev/null 2>&1
if [ $? -eq 0 ]; then
	# Replace first part with second
	sed -i "s|.*listen = 127.0.0.1.*|listen = 9000|g" $target
	echo "env[MARIADB_HOST] = \$MARIADB_HOST" >> $target
	echo "env[MARIADB_USER] = \$MARIADB_USER" >> $target
	echo "env[MARIADB_PWD] = \$MARIADB_PWD" >> $target
	echo "env[MARIADB_DB] = \$MARIADB_DB" >> $target
fi

# Enter if file doesn't exist yet
if [ ! -f "wp-config.php" ]; then
	cp /config/wp-config ./wp-config.php

	# We have to wait a bit or else the next steps will be skipped
	# In the meantime, connection to database is happening
	sleep 5 

	# Wordpress configuration
	wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" \
    	--admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL" --skip-email


	wp plugin update --all

	# Install and activate theme
	wp theme install twentysixteen --activate

	wp user create $WP_USER $WP_USER_EMAIL --role=editor --user_pass=$WP_USER_PWD

	# Creation d'un article pour l'example
	wp post generate --count=1 --post_title="example-post"
fi

# We need this to run wordpress but also so that the container keeps running
# --nodaemonize == keep foreground
php-fpm7 --nodaemonize