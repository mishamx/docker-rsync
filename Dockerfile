FROM debian:jessie

MAINTAINER Mikhail Mangushev

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
        rsync \
        ssh \
        cron \
        vim \
        supervisor \
    && rm -r /var/lib/apt/lists/*

RUN mkdir -p /data \
    && chmod a+rw /data

ADD ./run_from /usr/local/bin/run_from
ADD ./run_to /usr/local/bin/run_to
ADD ./cron /etc/cron
ADD ./supervisord.conf /etc/supervisor/supervisord.conf
ADD ./docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 873

RUN crontab /etc/cron \
	&& chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/local/bin/run_from"]