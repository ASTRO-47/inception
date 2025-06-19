FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server

RUN mkdir -p /etc/mysql/conf.d

COPY ./tools/init.sh /

RUN chmod +x /init.sh

CMD ["/init.sh"]



