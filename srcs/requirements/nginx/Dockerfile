FROM debian:bookworm

RUN apt update && apt install -y \
wget \
curl \
vim \
openssl \
nginx 

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

COPY ./conf/startup.sh /usr/local/bin/startup.sh

RUN chmod +x /usr/local/bin/startup.sh

ENTRYPOINT ["/usr/local/bin/startup.sh"]
