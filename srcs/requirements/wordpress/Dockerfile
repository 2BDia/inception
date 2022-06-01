FROM	alpine:3.16

# Update packet manager
RUN		apk update
# Download tools
RUN		apk add --no-cache --quiet --update curl bash vim
RUN		apk add --no-cache --quiet --update mariadb-client
RUN		apk add --no-cache --quiet --update php7 php-phar \
			php-json php-curl php-fpm php-mysqli php-iconv

# Create wordpress directory
RUN		mkdir -p /var/www/wordpress 

# Download wordpress and add execution rights to the wp cli command
RUN		curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
			--output /usr/bin/wp 
RUN		chmod +x ./usr/bin/wp 
RUN		wp core download --path=/var/www/wordpress

# Change workdir to wordpress dir
WORKDIR /var/www/wordpress

# Copy config file
COPY	tools/wp-config /config/wp-config

# Copy entrypoint script and add execution rights
COPY	./scripts/entrypoint.sh /tmp/entrypoint.sh
RUN		chmod +x /tmp/entrypoint.sh

# Execute script with entrypoint to make sure it's never ignored
ENTRYPOINT ["sh", "/tmp/entrypoint.sh"]