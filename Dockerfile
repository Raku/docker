# When releasing:
#
#   - Change the URL in the RUN curl... command to the target release
#   - build as such: docker build -t hoelzro/rakudo-star:$VERSION .

FROM ubuntu:14.04
MAINTAINER Rob Hoelz

WORKDIR /root

RUN apt-get update
RUN apt-get --yes install curl build-essential

RUN curl -L http://rakudo.org/downloads/star/rakudo-star-2015.03.tar.gz | tar xzf -

WORKDIR /root/rakudo-star-2015.03

RUN perl Configure.pl --prefix=/usr --gen-moar
RUN make install

ENTRYPOINT perl6