FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y
RUN apt install -y php-fpm php-mysqli curl mariadb-client 

RUN echo "listen=0.0.0.0:9000" >> /etc/php/7.4/fpm/php-fpm.conf

COPY tools/script.bash /script.bash

RUN chmod +x /script.bash

RUN mkdir -p /run/php

WORKDIR /var/www/wordpress

CMD ["/script.bash"]