FROM mono:5.0

RUN apt-get update \
 && apt-get install -y git autoconf libtool automake build-essential gettext cmake

ENV PREFIX=/usr/local
ENV VERSION=5.0.1.1

WORKDIR /build/
RUN curl -O https://download.mono-project.com/sources/mono/mono-$VERSION.tar.bz2 \
 && tar xf mono-$VERSION.tar.bz2
WORKDIR /build/mono-$VERSION
RUN ./configure --prefix=$PREFIX \
 && make \
 && make install

CMD ["/bin/bash"]