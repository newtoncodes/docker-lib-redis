FROM newtoncodes/ubuntu:16.04

RUN groupadd -r redis && useradd -r -g redis redis

RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y redis-server
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm -rf /var/lib/redis && mkdir -p /var/lib/redis /var/run/redis
RUN mkdir -p /var/lib/redis
RUN chown -R redis:redis /var/lib/redis /var/log/redis /var/run/redis && chmod 777 /var/run/redis

COPY redis.conf /etc/redis/redis.conf

COPY entrypoint.sh /usr/bin/entrypoint
RUN chmod +x /usr/bin/entrypoint

ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["redis-server"]

VOLUME ["/var/lib/redis", "/var/log/redis"]
EXPOSE 6379
