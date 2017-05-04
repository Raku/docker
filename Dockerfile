FROM buildpack-deps:jessie-scm
MAINTAINER Rob Hoelz

RUN groupadd -r perl6 && useradd -r -g perl6 perl6

ENV rakudo_version=2017.04

RUN buildDeps=' \
        gcc \
        libc6-dev \
        libencode-perl \
        make \
    ' \
    && set -x \
    && apt-get update \
    && apt-get --yes install --no-install-recommends $buildDeps \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /root/rakudo \
    && curl -fsSL http://rakudo.org/downloads/star/rakudo-star-${rakudo_version}.tar.gz -o rakudo.tar.gz \
    && tar xzf rakudo.tar.gz --strip-components=1 -C /root/rakudo \
    && ( \
        cd /root/rakudo \
        && perl Configure.pl --prefix=/usr --gen-moar \
        && make install \
    ) \
    && rm -rf /rakudo.tar.gz /root/rakudo \
    && apt-get purge -y --auto-remove $buildDeps

ENV PATH=$PATH:/usr/share/perl6/site/bin

CMD ["perl6"]
