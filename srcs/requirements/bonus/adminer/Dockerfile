FROM debian:bullseye

RUN apt-get update

RUN apt-get install -y php-mysqli && \
    apt-get install -y php wget && \
    mkdir -p /var/www/html && \
    wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O /var/www/html/index.php

WORKDIR /var/www/html

CMD ["php", "-S", "0.0.0.0:8082"]

#-S flag
