FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y redis-server

RUN sed -i 's/^bind .*/bind 0.0.0.0/' /etc/redis/redis.conf && \
sed -i 's/^# requirepass .*/requirepass redispass/' /etc/redis/redis.conf 

# Expose the Redis default port
# EXPOSE 6379

# Command to run Redis server
CMD ["redis-server", "--protected-mode", "no"]