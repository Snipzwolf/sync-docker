# Resilio Sync
#
# VERSION               0.1
#

FROM ubuntu
MAINTAINER Resilio Inc. <support@resilio.com>
LABEL com.resilio.version="2.6.3"

ARG TAR_URL=https://download-cdn.resilio.com/stable/linux-arm/resilio-sync_arm.tar.gz

RUN apt-get update && \
    apt-get -y install wget && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    wget -O /tmp/sync.tgz $TAR_URL

RUN tar -xf /tmp/sync.tgz -C /usr/bin rslsync && rm -f /tmp/sync.tgz

COPY sync.conf.default /etc/
COPY run_sync /usr/bin/

EXPOSE 8888/tcp
EXPOSE 55555/tcp
EXPOSE 55555/udp

# More info about ports used by Sync you can find here:
# https://help.resilio.com/hc/en-us/articles/204754759-What-ports-and-protocols-are-used-by-Sync-

VOLUME /mnt/sync

ENTRYPOINT ["run_sync"]
CMD ["--config", "/mnt/sync/sync.conf"]
