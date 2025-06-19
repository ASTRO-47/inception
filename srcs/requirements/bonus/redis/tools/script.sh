#!/bin/bash

echo "maxmemory 256mb" >> /etc/redis/redis.conf

sed -i 's/^bind .*/bind 0.0.0.0/' /etc/redis/redis.conf

echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis.conf # policy when memory is full (least recently used key get deleted)

sed -i "s/^# requirepass .*/requirepass $REDIS_PASS/" /etc/redis/redis.conf # add this

sed -i 's/^daemonize yes/daemonize no/' /etc/redis/redis.conf

redis-server /etc/redis/redis.conf

# redis-server --protected-mode no