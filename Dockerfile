FROM nvidia/cudagl:11.1-devel-ubuntu20.04

RUN rm -rf /etc/apt/sources.list.d/* && \
	apt update && \
	env DEBIAN_FRONTEND=noninteractive apt -y install wget tar git autoconf automake build-essential libass-dev libfreetype6-dev libsdl2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texinfo wget zlib1g-dev yasm nasm libx264-155 libx264-dev libx265-179 libx265-dev libmp3lame0 libmp3lame-dev libopus0 libopus-dev libavdevice58 libavdevice-dev libfreetype6-dev libevent-dev libsqlite3-dev libgl1-mesa-dev libglu-dev liblua5.3-dev p7zip-full && \
	rm -rf /var/tmp/* /tmp/* /var/lib/apt/lists/*

RUN mkdir /build && \
	cd /build && \
	git clone --depth=1 https://git.ffmpeg.org/ffmpeg.git ffmpeg && \
	git clone --depth=1 https://git.videolan.org/git/ffmpeg/nv-codec-headers.git nv-codec-headers && \
	cd nv-codec-headers && \
	make -j$(nproc) && make install && \
	cd ../ffmpeg && \
	./configure --enable-cuda --enable-cuvid --enable-nvenc --enable-nonfree --enable-libnpp --enable-yasm --enable-libx264 --enable-libx265 --enable-libmp3lame --enable-libopus --enable-shared --enable-gpl --enable-pthreads --extra-cflags=-I/usr/local/cuda/include --extra-ldflags=-L/usr/local/cuda/lib64 && \
	make -j$(nproc) && make install && \
	rm -rf /build

WORKDIR /usr/src/app
COPY . ./
RUN git clone --depth=1 https://code.mycard.moe/mycard/irrlicht irricht_linux && \
	wget -O - https://github.com/premake/premake-core/releases/download/v5.0.0-alpha14/premake-5.0.0-alpha14-linux.tar.gz | tar zfx - && \
	./premake5 gmake && \
	cd build && make -j$(nproc) && cd .. && \
	cp -rf bin/release/ygopro . && \
	strip ygopro && \
	wget -O ygopro-images-zh-CN.zip https://cdn01.moecube.com/images/ygopro-images-zh-CN.zip && \
	7z x -y -opics ygopro-images-zh-CN.zip && \
	rm -rf ygopro-images-zh-CN.zip && \
	mkdir fonts && \
	cd fonts && \
	wget -O - https://cdn01.moecube.com/ygopro-fonts.tar.gz | tar zfx -  && \
	cd ..
