FROM debian:bullseye

RUN apt update && apt install -y nginx openssl

COPY tools/conf/nginx.conf /etc/nginx/sites-enabled/default

RUN mkdir -p /etc/nginx/ssl

COPY tools/public /var/www/static

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=MA/ST=BeniMellal/L=Khouribga/O=42/OU=42/CN=iez-zagh.42.fr"

CMD ["nginx", "-g", "daemon off;"]
