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
        perl-encode \
    ' \
    \
    url="https://rakudo.org/dl/star/rakudo-star-${rakudo_version}.tar.gz" \
    keyserver='ha.pool.sks-keyservers.net' \
    keyfp='ECF8B611205B447E091246AF959E3D6197190DD5 7A6C9EB8809CFEAF0ED4E09F18C438E6FF24326D B6F697742EFCAF5F23CE51D5031D65902E840821' \
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
    && apk del .build-deps

ENV PATH=$PATH:/usr/share/perl6/site/bin

CMD ["raku"]
