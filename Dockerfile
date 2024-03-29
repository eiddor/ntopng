FROM ubuntu:18.04
MAINTAINER Roddie Hasan <roddie@krweb.net>

RUN apt-get update && \
    apt-get -y -q install wget lsb-release gnupg && \
    wget -q http://apt.ntop.org/18.04/all/apt-ntop.deb && \
    dpkg -i apt-ntop.deb && \
    apt-get clean all

RUN apt-get update && \
    apt-get -y install ntopng

RUN echo '#!/bin/bash\n/etc/init.d/redis-server start\nntopng "$@"' > /run.sh && \
    chmod +x /run.sh

EXPOSE 3000

ENTRYPOINT ["/run.sh"]
