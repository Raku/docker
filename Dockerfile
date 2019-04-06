FROM buildpack-deps:stretch-scm
MAINTAINER Rob Hoelz

RUN groupadd -r perl6 && useradd -r -g perl6 perl6

ARG rakudo_version=2019.03
ENV rakudo_version=${rakudo_version}

RUN buildDeps=' \
        gcc \
        libc6-dev \
        libencode-perl \
        make \
    ' \
    \
    keyfp=$( \
        timestampFromDate() { \
            date -d $(echo $1 | cut -c1-7 | tr . - | xargs printf '%s-01') '+%s'; \
        }; \
        \
        if [ $(timestampFromDate $rakudo_version) -lt $(timestampFromDate '2019.03') ]; then \
            echo 'ECF8B611205B447E091246AF959E3D6197190DD5'; \
        else \
            echo '7A6C9EB8809CFEAF0ED4E09F18C438E6FF24326D'; \
        fi \
    ) \
    \
    url="https://rakudo.org/downloads/star/rakudo-star-${rakudo_version}.tar.gz" \
    keyserver='ha.pool.sks-keyservers.net' \
    tmpdir="$(mktemp -d)" \
    && set -x \
    && export GNUPGHOME="$tmpdir" \
    && apt-get update \
    && apt-get --yes install --no-install-recommends $buildDeps \
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
        && perl Configure.pl --prefix=/usr --gen-moar \
        && make install \
    ) \
    && rm -rf $tmpdir \
    && apt-get purge -y --auto-remove $buildDeps

ENV PATH=$PATH:/usr/share/perl6/site/bin

CMD ["perl6"]
