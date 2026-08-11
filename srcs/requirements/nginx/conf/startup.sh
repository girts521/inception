#!/bin/bash

echo "Creating the ssl certificate"
cert_file="/etc/ssl/certs/nginx.crt"

if [ ! -f "{$cert_file}" ]; then
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt \
    -subj "/C=DE/ST=Berlin/L=Berlin/O=42/CN={$HOSTNAME}"
fi

exec nginx -g "daemon off;"
