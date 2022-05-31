FROM	alpine:3.14

# Update packet manager
RUN		apk update

# Install nginx and openssl
RUN		apk add --no-cache --quiet --update nginx
RUN		apk add --no-cache --quiet --update openssl

# Create directory for the certificate and key (for HTTPS)
RUN		mkdir -p /etc/nginx/ssl

# Generate certificate and key
RUN 	openssl req -x509 -nodes \
	-out /etc/nginx/ssl/rvan-aud.42.fr.crt \	
	-keyout /etc/nginx/ssl/rvan-aud.42.fr.key \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=rvan-aud.42.fr/UID=rvan-aud"

# Create directory for the nginx config files
RUN 	mkdir -p /var/run/nginx

# Copy config file on the container
COPY	tools/nginx.conf /etc/nginx/http.d/default.conf

# Expose the only port we're allowed to use in the subject
EXPOSE	443

# Start nginx in the foreground
CMD	[ "nginx", "-g", "daemon off;" ]