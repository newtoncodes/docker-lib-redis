#!/usr/bin/env bash

if [ "$1" = "redis-server" ]; then
    if [ ! -z "$ROOT_PASSWORD" ]; then
        sed -i "s/#*masterauth.*/masterauth $ROOT_PASSWORD/" /etc/redis/redis.conf && \
        sed -i "s/#*requirepass.*/requirepass $ROOT_PASSWORD/" /etc/redis/redis.conf
    else
        if [ -f "/etc/redis/passwd" ]; then
            ROOT_PASSWORD=$(cat /etc/redis/passwd)

            sed -i "s/#*masterauth.*/masterauth $ROOT_PASSWORD/" /etc/redis/redis.conf && \
            sed -i "s/#*requirepass.*/requirepass $ROOT_PASSWORD/" /etc/redis/redis.conf
        else
            sed -i "s/#*masterauth.*/#masterauth/" /etc/redis/redis.conf && \
            sed -i "s/#*requirepass.*/#requirepass/" /etc/redis/redis.conf
        fi
    fi

    exec redis-server /etc/redis/redis.conf
else
    exec "$@"
fi