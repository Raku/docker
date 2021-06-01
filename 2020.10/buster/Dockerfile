FROM buildpack-deps:buster-scm
MAINTAINER Rob Hoelz

RUN groupadd -r raku && useradd -m -r -g raku raku

ARG rakudo_version=2020.10
ENV rakudo_version=${rakudo_version}

RUN buildDeps=' \
        gcc \
        libc6-dev \
        make \
    ' \
    \
    url="https://rakudo.org/dl/star/rakudo-star-${rakudo_version}.tar.gz" \
    keyserver='ha.pool.sks-keyservers.net' \
    keyfp='B6F697742EFCAF5F23CE51D5031D65902E840821' \
    tmpdir="$(mktemp -d)" \
    && set -eux \
    && export GNUPGHOME="$tmpdir" \
    && apt-get update \
    && apt-get install -y --no-install-recommends $buildDeps \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir ${tmpdir}/rakudo \
    \
    && curl -fsSL ${url}.asc -o ${tmpdir}/rakudo.tar.gz.asc \
    && curl -fsSL $url -o ${tmpdir}/rakudo.tar.gz \
    && gpg --batch --keyserver $keyserver --recv-keys $keyfp \
    && gpg --batch --verify ${tmpdir}/rakudo.tar.gz.asc ${tmpdir}/rakudo.tar.gz \
    \
    && tar xzf ${tmpdir}/rakudo.tar.gz --strip-components=1 -C ${tmpdir}/rakudo \
    && ( \
        cd ${tmpdir}/rakudo \
        && bash bin/rstar install -p /usr \
    ) \
    && rm -rf $tmpdir \
    && apt-get purge -y --auto-remove $buildDeps

ENV PATH=$PATH:/usr/share/perl6/core/bin:/usr/share/perl6/site/bin:/usr/share/perl6/vendor/bin

CMD ["raku"]
