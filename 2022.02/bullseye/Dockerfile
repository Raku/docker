FROM buildpack-deps:bullseye-scm
MAINTAINER Rob Hoelz

RUN groupadd -r raku && useradd -m -r -g raku raku

ARG rakudo_version=2022.02-01
ENV rakudo_version=${rakudo_version}

RUN set -eux; \
    buildDeps=' \
        gcc \
        libc6-dev \
        make \
    ' \
    \
    url="https://rakudo.org/dl/star/rakudo-star-${rakudo_version}.tar.gz" \
    sha256='bb658a67b792c355bbfad71e3d486b6c18bbfa108260c53bf351d8c40a1ad42a' \
    tmpdir="$(mktemp -d)"; \
    apt-get update; \
    apt-get install -y --no-install-recommends $buildDeps; \
    rm -rf /var/lib/apt/lists/*; \
    mkdir ${tmpdir}/rakudo; \
    \
    curl -fsSL $url -o ${tmpdir}/rakudo.tar.gz; \
    echo $sha256 ${tmpdir}/rakudo.tar.gz | sha256sum -c -; \
    \
    tar xzf ${tmpdir}/rakudo.tar.gz --strip-components=1 -C ${tmpdir}/rakudo; \
    ( \
        cd ${tmpdir}/rakudo; \
        bash bin/rstar install -p /usr \
    ); \
    rm -rf $tmpdir; \
    apt-get purge -y --auto-remove $buildDeps

ENV PATH=$PATH:/usr/share/perl6/core/bin:/usr/share/perl6/site/bin:/usr/share/perl6/vendor/bin

CMD ["raku"]
