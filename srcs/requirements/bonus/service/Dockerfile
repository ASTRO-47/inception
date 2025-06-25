FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs git && \
    npm install -g redis-commander && \
    apt-get clean

COPY tools/script.sh /

RUN chmod +x script.sh

# CMD ["redis-commander", "--redis-host", "redis", "--port", "8081"]
CMD ["./script.sh"]
