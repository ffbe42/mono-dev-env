FROM mono:5.0

RUN apt-get update \
 && apt-get install -y git autoconf libtool automake build-essential gettext cmake python nano

ENV PREFIX=/usr/local
ENV VERSION=5.0.1.1

WORKDIR /build/
RUN curl -O https://download.mono-project.com/sources/mono/mono-$VERSION.tar.bz2 \
 && tar xf mono-$VERSION.tar.bz2
WORKDIR /build/mono-$VERSION
RUN ./configure --prefix=$PREFIX \
 && make \
 && make install

# use dev mono as default
ENV MONO_PREFIX=$PREFIX
ENV GNOME_PREFIX=/opt/gnome
ENV DYLD_FALLBACK_LIBRARY_PATH=$MONO_PREFIX/lib:$DYLD_LIBRARY_FALLBACK_PATH
ENV LD_LIBRARY_PATH=$MONO_PREFIX/lib:$LD_LIBRARY_PATH
ENV C_INCLUDE_PATH=$MONO_PREFIX/include:$GNOME_PREFIX/include
ENV ACLOCAL_PATH=$MONO_PREFIX/share/aclocal
ENV PKG_CONFIG_PATH=$MONO_PREFIX/lib/pkgconfig:$GNOME_PREFIX/lib/pkgconfig
ENV PATH=$MONO_PREFIX/bin:$PATH

CMD ["/bin/bash"]