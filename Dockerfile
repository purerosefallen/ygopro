FROM nvidia/cudagl:10.2-devel-ubuntu18.04

RUN rm -rf /etc/apt/sources.list.d/* && \
	apt update && \
	apt -y install software-properties-common && \
	add-apt-repository -y ppa:savoury1/graphics && \
	add-apt-repository -y ppa:savoury1/multimedia && \
	add-apt-repository -y ppa:savoury1/ffmpeg4 && \
	env DEBIAN_FRONTEND=noninteractive apt -y install wget tar git autoconf automake build-essential ffmpeg libfreetype6-dev libevent-dev libsqlite3-dev libgl1-mesa-dev libglu-dev liblua5.3-dev libxxf86vm-dev p7zip-full libffmpeg-nvenc-dev && \
	rm -rf /var/tmp/* /tmp/* /var/lib/apt/lists/*


WORKDIR /usr/src/app
COPY . ./
RUN git clone --depth=1 https://code.mycard.moe/mycard/irrlicht irrlicht_linux && \
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
	cd .. && \
	cp -rf system.conf system_user.conf

RUN ln -s /usr/local/cuda/compat/libcuda.so.1 /usr/lib/x86_64-linux-gnu/libcuda.so.1

ENV DISPLAY ":0"
CMD ["./docker/record-video.sh"]
