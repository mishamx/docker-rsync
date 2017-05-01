FROM debian:jessie

MAINTAINER Mikhail Mangushev

RUN apt-get update \
   && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
      rsync \
      ssh \
      && rm -r /var/lib/apt/lists/*

RUN mkdir -p /data \
   && chmod a+rw /data

ADD ./run_from /usr/local/bin/run_from
ADD ./run_to /usr/local/bin/run_to

EXPOSE 873

CMD ["/usr/local/bin/run_from"]