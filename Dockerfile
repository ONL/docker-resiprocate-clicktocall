FROM centos:7

RUN yum upgrade -y \
    && yum install -y epel-release \
    && yum install -y \
      wget resiprocate-clicktocall \
    && yum clean all

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64 \
  && chmod +x /usr/local/bin/dumb-init

WORKDIR /etc/clicktocall

RUN wget https://raw.githubusercontent.com/resiprocate/resiprocate/master/apps/clicktocall/clicktocall.config

EXPOSE 5090 5094 5073
EXPOSE 5072/udp

VOLUME /etc/clicktocall

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["/usr/sbin/clicktocall"]
