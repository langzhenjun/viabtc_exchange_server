# build
FROM ubuntu

RUN apt-get update -y && apt-get dist-upgrade -y
RUN apt-get install -y make gcc
RUN apt-get install -y libev-dev
RUN apt-get install -y libhiredis-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y libjansson-dev
RUN apt-get install -y librdkafka-dev
RUN apt-get install -y libmpdec-dev
RUN apt-get install -y libmysqlclient-dev

COPY makefile.inc /root/makefile.inc
COPY network /root/network
COPY utils /root/utils 
COPY accesshttp /root/accesshttp

WORKDIR /root/network
RUN make clean all

WORKDIR /root/utils
RUN make clean all

WORKDIR /root/accesshttp
RUN make clean all

# runtime
FROM alpine
WORKDIR /root
COPY --from=0 /root/accesshttp/accesshttp .
CMD ["./accesshttp"]