FROM debian:jessie
MAINTAINER Rob Hoelz

ENV rakudo_version=2015.03

RUN groupadd -r perl6 && useradd -r -g perl6 perl6

ADD http://rakudo.org/downloads/star/rakudo-star-${rakudo_version}.tar.gz /root/
RUN tar xzf /root/rakudo-star-${rakudo_version}.tar.gz -C /root/

RUN apt-get update && apt-get --yes install \
    gcc \
    make \
    perl-modules

WORKDIR /root/rakudo-star-${rakudo_version}

RUN perl Configure.pl --prefix=/usr --gen-moar
RUN make install

USER perl6
ENTRYPOINT ["perl6"]
