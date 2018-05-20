# build
FROM gcc:6

RUN apt-get update -y && apt-get dist-upgrade -y
RUN apt-get install -y libev-dev libhiredis-dev libjansson-dev librdkafka-dev libmpdec-dev libmysqlclient-dev

RUN apt-get install -y libgss-dev

RUN apt-get install -y libcrypto++9

COPY makefile.inc /root/makefile.inc
COPY network /root/network
COPY utils /root/utils 
COPY accessws /root/accessws

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