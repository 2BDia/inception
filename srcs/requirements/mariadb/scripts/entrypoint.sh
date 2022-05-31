cat .setup 2> /dev/null
if [ $? -ne 0 ]; then
	# Start mysql in safe mode, with "&" to be able to apply modifications
	usr/bin/mysqld_safe --datadir=/var/lib/mysql &

	# We wait for the database to be accessible
	while ! mysqladmin ping -h "$MARIADB_HOST" --silent; do
    	sleep 1
	done

	eval "echo \"$(cat /tmp/create_db.sql)\"" | mariadb
	touch .setup
fi
# Start mysql in safe mode normally
usr/bin/mysqld_safe --datadir=/var/lib/mysql