FROM debian:bullseye

RUN apt-get update 

RUN apt-get install -y vsftpd
    
COPY tools/ftp.conf /etc/vsftpd.conf

COPY tools/script.sh /

RUN chmod +x script.sh

CMD ["./script.sh"]