FROM alpine:3.12

RUN addgroup -S raku && adduser -S raku -G raku

ARG rakudo_version=2020.10
ENV rakudo_version=${rakudo_version}

RUN buildDeps=' \
        bash \
        gcc \
        gnupg \
        libc-dev \
        make \
        perl \
    ' \
    \
    url="https://rakudo.org/dl/star/rakudo-star-${rakudo_version}.tar.gz" \
    keyserver='ha.pool.sks-keyservers.net' \
    keyfp='B6F697742EFCAF5F23CE51D5031D65902E840821' \
    tmpdir="$(mktemp -d)" \
    && set -x \
    && export GNUPGHOME="$tmpdir" \
    && apk add --no-cache --virtual .build-deps $buildDeps \
    && mkdir ${tmpdir}/rakudo \
    \
    && wget ${url}.asc -O ${tmpdir}/rakudo.tar.gz.asc \
    && wget $url -O ${tmpdir}/rakudo.tar.gz \
    && gpg --batch --keyserver $keyserver --recv-keys $keyfp \
    && gpg --batch --verify ${tmpdir}/rakudo.tar.gz.asc ${tmpdir}/rakudo.tar.gz \
    \
    && tar xzf ${tmpdir}/rakudo.tar.gz --strip-components=1 -C ${tmpdir}/rakudo \
    && ( \
        cd ${tmpdir}/rakudo \
        && bash bin/rstar install -p /usr \
    ) \
    && rm -rf $tmpdir \
    && apk del --no-network .build-deps

ENV PATH=$PATH:/usr/share/perl6/site/bin

CMD ["raku"]
