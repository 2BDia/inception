FROM	alpine:3.16

# Update packet manager
RUN		apk update

# Install mariadb and mariadb-client
RUN		apk add --no-cache --quiet --update mariadb mariadb-client vim

# Create directory for the daemon
RUN 	mkdir -p /var/lib/mysqld /run/mysqld

# Copy and execute database creaton script
COPY	./tools/create_db.sql /tmp/create_db.sql

# Copy entrypoint script and add execution rights
COPY	./scripts/entrypoint.sh ./
RUN 	chmod +x ./entrypoint.sh

# Copy mariadb conf file
COPY 	./tools/mariadb-server.cnf /etc/my.cnf.d/

# Install database et authetificate
RUN		mariadb-install-db --datadir=/var/lib/mysql \
			--auth-root-authentication-method=normal

# Change ownership for mysql files
RUN		chown -R mysql:mysql /var/lib/mysql 
RUN 	chown -R mysql:mysql /run/mysqld

# Execute script with entrypoint to make sure it's never ignored
ENTRYPOINT [ "sh", "entrypoint.sh" ]