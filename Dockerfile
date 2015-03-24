FROM debian:jessie
MAINTAINER Rob Hoelz

ADD http://rakudo.org/downloads/star/rakudo-star-2015.03.tar.gz /root/
RUN tar xzf /root/rakudo-star-2015.03.tar.gz -C /root/

RUN apt-get update && apt-get --yes install \
    gcc \
    make \
    perl-modules

WORKDIR /root/rakudo-star-2015.03

RUN perl Configure.pl --prefix=/usr --gen-moar
RUN make install

ENTRYPOINT ["perl6"]
