FROM buildpack-deps:bookworm-scm
MAINTAINER Rob Hoelz

RUN groupadd -r raku && useradd -m -r -g raku raku

ARG rakudo_version=2024.09-01
ENV rakudo_version=${rakudo_version}

RUN buildDeps=' \
        gcc \
        libc6-dev \
        make \
    ' \
    \
    url="https://rakudo.org/dl/star/rakudo-star-${rakudo_version}.tar.gz" \
    keyfp="3E7E3C6EAF916676AC549285A2919382E961E2EE" \
    pubkeyurl="https://rakudo.org/keys/rakudo_github_automation-${keyfp}.asc" \
    tmpdir="$(mktemp -d)" \
    && set -eux \
    && export GNUPGHOME="$tmpdir/gnupg" \
    && mkdir $GNUPGHOME \
    && apt-get update \
    && apt-get install -y --no-install-recommends $buildDeps \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir ${tmpdir}/rakudo \
    \
    && curl -fsSL ${url}.asc -o ${tmpdir}/rakudo.tar.gz.asc \
    && curl -fsSL $url -o ${tmpdir}/rakudo.tar.gz \
    && curl -fsSL $pubkeyurl -o ${tmpdir}/key.asc \
    \
    && gpg --batch --import ${tmpdir}/key.asc \
    && gpg --batch --export $keyfp > ${tmpdir}/${keyfp}.asc \
    && rm -rf $GNUPGHOME \
    && mkdir $GNUPGHOME \
    && gpg --batch --import ${tmpdir}/${keyfp}.asc \
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
