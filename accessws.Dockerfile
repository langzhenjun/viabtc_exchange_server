# build
FROM ubuntu

RUN apt-get update -y && apt-get dist-upgrade -y
RUN apt-get install -y make gcc
# RUN apt-get install -y libev-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y libjansson-dev
RUN apt-get install -y librdkafka-dev
RUN apt-get install -y libmpdec-dev
RUN apt-get install -y libmysqlclient-dev
# RUN apt-get install -y libnghttp2-dev
# RUN apt-get install -y libcrypto++-dev
RUN apt-get install -y liblz4-dev liblz4-tool

COPY depends /root/depends
COPY makefile.inc /root/makefile.inc
COPY network /root/network
COPY utils /root/utils 
COPY accessws /root/accessws

WORKDIR /root/depends/curl
RUN make && make install

# WORKDIR /root/depends/http-parser
# RUN make && make install

WORKDIR /root/depends/hiredis
RUN make && make install

RUN apt-get install -y autoconf libtool
WORKDIR /root/depends/libev
RUN ./configure CFLAGS=-fPIC
RUN make && make install

WORKDIR /root/network
RUN make clean all

WORKDIR /root/utils
RUN make clean all

WORKDIR /root/accessws
RUN make clean all

# runtime
FROM alpine
WORKDIR /root
COPY --from=0 /root/accessws/accessws .
CMD ["./accessws"]