FROM nvidia/cudagl:10.2-devel-ubuntu18.04
LABEL Author="Nanahira <nanahira@momobako.com>"

RUN rm -rf /etc/apt/sources.list.d/* && \
	apt update && \
	env DEBIAN_FRONTEND=noninteractive apt -y install wget tar git autoconf automake build-essential libfreetype6-dev libevent-dev libsqlite3-dev libgl1-mesa-dev libglu-dev liblua5.3-dev libxxf86vm-dev p7zip-full mono-complete libasound2-dev libasound2 && \
	rm -rf /var/tmp/* /tmp/* /var/lib/apt/lists/*


WORKDIR /usr/src/app
COPY . ./

	# irrlicht
RUN git clone --depth=1 https://code.mycard.moe/mycard/irrlicht irrlicht_linux && \
	# irrklang
	#wget -O irrKlang.zip https://www.ambiera.at/downloads/irrKlang-64bit-1.6.0.zip && \
	#7z x -y irrKlang.zip && \
	#mv irrKlang-64bit-1.6.0 irrklang && \
	#cp -rf irrklang/bin/linux-gcc-64/libIrrKlang.so . && \
	# premake
	wget -O - https://github.com/premake/premake-core/releases/download/v5.0.0-alpha14/premake-5.0.0-alpha14-linux.tar.gz | tar zfx - && \
	./premake5 gmake && \
	# build
	cd build && make config=release -j$(nproc) && cd .. && \
	cp -rf bin/release/ygopro . && \
	strip ygopro && \
	# images
	wget -O ygopro-images-zh-CN.zip https://cdn01.moecube.com/images/ygopro-images-zh-CN.zip && \
	7z x -y -opics ygopro-images-zh-CN.zip && \
	rm -rf ygopro-images-zh-CN.zip && \
	# sound
	#wget -O - https://code.mycard.moe/mycard/ygopro-sounds/-/archive/master/ygopro-sounds-master.tar.gz | tar zfx - && \
	#mv ygopro-sounds-master/sound/* sound && \
	#rm -rf ygopro-sounds-master && \
	# fonts
	mkdir fonts && \
	cd fonts && \
	wget -O - https://cdn01.moecube.com/ygopro-fonts.tar.gz | tar zfx - && \
	cd .. && \
	# windbot
	wget -O - https://cdn01.moecube.com/windbot/windbot.tar.gz | tar zfx - && \
	# starter pack
	wget -O - https://code.mycard.moe/mycard/ygopro-starter-pack/-/archive/master/ygopro-starter-pack-master.tar.gz | tar zfx - && \
	mv ygopro-starter-pack-master/* . && \
	rm -rf ygopro-starter-pack-master && \
	# locales
	git clone --depth=1 https://github.com/purerosefallen/ygopro-database && \
	mv -f ygopro-database/locales . && \
	rm -rf  ygopro-database && \
	# cleanup
	cp -rf system.conf system_user.conf && \
	rm -rf bin obj build premake5 irrlicht_linux

RUN ln -s /usr/local/cuda/compat/libcuda.so.1 /usr/lib/x86_64-linux-gnu/libcuda.so.1

ENV DISPLAY ":0"
CMD ["./ygopro"]
