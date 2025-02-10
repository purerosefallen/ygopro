FROM debian:buster-slim as git-checkout

RUN apt update && \
    env DEBIAN_FRONTEND=noninteractive apt install -y git wget tar && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr/src/app
COPY .git ./.git

RUN	git checkout -f && \
	git submodule update --init && \
	git submodule foreach git checkout master && \
	wget -O - https://github.com/premake/premake-core/releases/download/v5.0.0-alpha14/premake-5.0.0-alpha14-linux.tar.gz | tar zfx - && \
	./premake5 gmake


FROM debian:buster-slim as builder

# apt
RUN apt update && \
    env DEBIAN_FRONTEND=noninteractive apt install -y build-essential libsqlite3-dev libevent-dev liblua5.3-dev && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


WORKDIR /usr/src/app
COPY --from=git-checkout /usr/src/app/ ./

RUN cd build && \
	make -j$(nproc) && \
	cd .. && \
	cp -rf bin/release/ygopro . && \
	strip ygopro

FROM debian:buster-slim

# apt
RUN apt update && \
    env DEBIAN_FRONTEND=noninteractive apt install -y libsqlite3-dev libevent-dev liblua5.3-dev && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/ygopro .
COPY --from=git-checkout /usr/src/app/script ./script
COPY ./lflist.conf .

ENTRYPOINT [ "./ygopro" ]
