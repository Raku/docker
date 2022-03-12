FROM alpine:3.15

RUN addgroup -S raku && adduser -S raku -G raku

ARG rakudo_version=2022.02-01
ENV rakudo_version=${rakudo_version}

RUN set -eux; \
    buildDeps=' \
        bash \
        gcc \
        libc-dev \
        make \
        perl \
    ' \
    \
    url="https://rakudo.org/dl/star/rakudo-star-${rakudo_version}.tar.gz" \
    sha256='bb658a67b792c355bbfad71e3d486b6c18bbfa108260c53bf351d8c40a1ad42a' \
    tmpdir="$(mktemp -d)"; \
    apk add --no-cache --virtual .build-deps $buildDeps; \
    mkdir ${tmpdir}/rakudo; \
    \
    wget $url -O ${tmpdir}/rakudo.tar.gz; \
    echo $sha256 ${tmpdir}/rakudo.tar.gz | sha256sum -c -; \
    \
    tar xzf ${tmpdir}/rakudo.tar.gz --strip-components=1 -C ${tmpdir}/rakudo; \
    ( \
        cd ${tmpdir}/rakudo; \
        bash bin/rstar install -p /usr \
    ); \
    rm -rf $tmpdir; \
    apk del --no-network .build-deps

ENV PATH=$PATH:/usr/share/perl6/core/bin:/usr/share/perl6/site/bin:/usr/share/perl6/vendor/bin

CMD ["raku"]
