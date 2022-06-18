FROM alpine:3.13

RUN addgroup -S raku && adduser -S raku -G raku

ARG rakudo_version=2022.04

ENV rakudo_version      ${rakudo_version}
ENV rakudo_raw_filename rakudo-star-${rakudo_version}-01.tar.gz
ENV file_url            https://rakudo.org/dl/star/${rakudo_raw_filename}
ENV checksum_url        https://rakudo.org/dl/star/${rakudo_raw_filename}.sha256.checksum.txt
ENV tmpdir              /tmp/rakudo-star

RUN mkdir ${tmpdir}
RUN chown -R $(whoami) ${tmpdir}
RUN chmod 600 ${tmpdir}
RUN chmod 700 ${tmpdir}

WORKDIR ${tmpdir}

ADD ${file_url} .
ADD ${checksum_url} .

ENV buildDeps ' \
        bash \
        gcc \
        gnupg \
        libc-dev \
        make \
        perl \
    '
RUN set -ex; apk add --no-cache --virtual .build-deps ${buildDeps}

# Verify
ENV keyserver keyserver.ubuntu.com
ENV keyfp B6F697742EFCAF5F23CE51D5031D65902E840821
RUN set -ex; GNUPGHOME=${tmpdir} gpg --keyserver ${keyserver} --recv-keys ${keyfp}
# RUN GNUPGHOME=${tmpdir} gpg --verify ${rakudo_raw_filename}

# In order to insert an extra space https://github.com/gliderlabs/docker-alpine/issues/174
# Break the file contents into parts and abuse a for loop to pick the actual checksum
RUN set -ex; \
    for part in $(cat "${rakudo_raw_filename}.sha256.checksum.txt"); do \
        if [ "$part" != "rakudo-star-${rakudo_version}.tar.gz" ]; then \
            echo "$part  ${rakudo_raw_filename}" | sha256sum -c -; \
        fi \
    done

# Build
RUN set -ex; mkdir rakudo && tar xzf ${rakudo_raw_filename} --strip-components=1 -C ./rakudo \
    && ( \
        cd ./rakudo \
        && bash bin/rstar install -p /usr \
    )

# Cleanup
WORKDIR /
RUN set -ex; rm -rf ${tmpdir}
RUN apk del --no-network .build-deps

ENV rakudo_raw_filename=
ENV file_url=
ENV checksum_url=
ENV tmpdir=

# Run
ENV PATH $PATH:/usr/share/perl6/core/bin:/usr/share/perl6/site/bin:/usr/share/perl6/vendor/bin
CMD ["raku"]
