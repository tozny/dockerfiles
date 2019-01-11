# Dockerfile written by Eric Mann <eric@tozny.com>
#
# Copyright (c) 2018 Tozny, LLC

FROM alpine:3.7

# ensure local python is preferred over distribution python
ENV PATH /usr/local/bin:/usr/local/python2/bin:$PATH

ENV LANG C.UTF-8
ENV PYTHON_VERSION 2.7.15
ENV PYTHON_PIP_VERSION 18.1

RUN apk update && apk add --no-cache \
	bzip2-dev \
	coreutils \
	curl \
	dpkg-dev dpkg \
	gcc \
	gdbm-dev \
	libc-dev \
	libffi-dev \
	libnsl-dev \
	libtirpc-dev \
	linux-headers \
	make \
	sqlite-dev \
	tcl-dev \
	tk \
	tk-dev \
	tar \
	xz \
	zlib-dev

RUN wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" \
	&& mkdir -p /usr/src/python \
	&& tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz \
	&& rm python.tar.xz \
	&& wget https://www.openssl.org/source/openssl-fips-2.0.16.tar.gz \
	&& wget https://www.openssl.org/source/openssl-1.0.2o.tar.gz \
	&& tar -xvf openssl-1.0.2o.tar.gz && tar -xvf openssl-fips-2.0.16.tar.gz

COPY openssl.ld /openssl.ld

RUN cd openssl-fips-2.0.16 && ./config && make && make install
RUN cd openssl-1.0.2o && ./config -Wl,--version-script=/openssl.ld -Wl,-Bsymbolic-functions -fPIC shared fips && make && make install

RUN ln -s -f /usr/local/ssl/bin/openssl /usr/bin/openssl \
    && cp /usr/local/ssl/lib/libcrypto.so.1.0.0 /lib/ \
	&& cp /usr/local/ssl/lib/libssl.so.1.0.0 /lib/

RUN gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
    && cd /usr/src/python \
	&& ./configure \
		 --build="$gnuArch" \
		 --enable-shared \
		 --enable-unicode=ucs4 \
		 --prefix=/usr/local/python2 \
	&& make && make install \
	&& cp /usr/local/python2/lib/libpython2.7.so.1.0 /usr/lib/ \
	&& cp /usr/local/python2/lib/libpython2.7.so.1.0 /lib/

ENV PATH /usr/local/python2/bin:$PATH

RUN wget -O get-pip.py 'https://bootstrap.pypa.io/get-pip.py' \
    && python get-pip.py \
        --disable-pip-version-check \
        --no-cache-dir \
        "pip==$PYTHON_PIP_VERSION" \
    && rm -f get-pip.py


RUN CFLAGS="-I/usr/local/ssl/include" LDFLAGS="-L/usr/local/ssl/lib" pip wheel --no-binary :all: cryptography \
    && pip install cryptography-*.whl

CMD ["python"]
