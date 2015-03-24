# When releasing:
#
#   - Change the URL in the RUN curl... command to the target release
#   - build as such: docker build -t hoelzro/rakudo-star:$VERSION .

FROM debian:jessie
MAINTAINER Rob Hoelz

WORKDIR /root

RUN apt-get update && apt-get --yes install build-essential

RUN curl -L http://rakudo.org/downloads/star/rakudo-star-2015.03.tar.gz | tar xzf -

WORKDIR /root/rakudo-star-2015.03

RUN perl Configure.pl --prefix=/usr --gen-moar
RUN make install

ENTRYPOINT perl6