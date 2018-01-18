#!/usr/bin/env bash

if [ "$1" = "redis-server" ]; then
    if [ ! -z "$REDIS_PASSWORD" ]; then
        sed -i "s/#*masterauth.*/masterauth $REDIS_PASSWORD/" /etc/redis/redis.conf && \
        sed -i "s/#*requirepass.*/requirepass $REDIS_PASSWORD/" /etc/redis/redis.conf
    else
        sed -i "s/#*masterauth.*/#masterauth/" /etc/redis/redis.conf && \
        sed -i "s/#*requirepass.*/#requirepass/" /etc/redis/redis.conf
    fi

    exec redis-server /etc/redis/redis.conf
else
    exec "$@"
fi