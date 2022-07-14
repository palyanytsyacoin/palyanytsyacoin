FROM debian:8.11 as pacoin_debian
# ADD ./docker/debian/6/sources.list /etc/apt/sources.list
RUN sed -i 's/deb.debian.org/debian.volia.net/g' /etc/apt/sources.list
RUN apt-get update && apt-get install -y build-essential
RUN apt-get install -y libssl-dev libqrencode-dev
RUN apt-get install -y libboost-all-dev
RUN apt-get install -y libdb-dev libdb++-dev

# RUN apt-get install -y libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev
RUN apt-get install -y qt4-qmake libqt4-dev

WORKDIR /pacoin
ADD ./src /pacoin/src
ADD ./contrib /pacoin/contrib
ADD ./share /pacoin/share
