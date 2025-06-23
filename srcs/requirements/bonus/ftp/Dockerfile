FROM debian:bullseye

RUN apt-get update 

RUN apt-get install -y vsftpd && \
    apt-get clean
    
COPY tools/ftp.conf /

COPY tools/script.sh /

RUN chmod +x script.sh

CMD ["./script.sh"]