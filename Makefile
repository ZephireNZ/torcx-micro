version = 2.0.11

build: clean torcx.tgz torcx.squashfs

clean:
	rm -rf build/
	rm -rf dist/

micro.tar.gz:
	mkdir -p build/
	wget -q https://github.com/zyedidia/micro/releases/download/v$(version)/micro-$(version)-linux64.tar.gz -O build/micro.tar.gz

micro: micro.tar.gz
	cd build && tar -xzf micro.tar.gz
	mv build/micro-* build/micro

torcx: micro
	mkdir -p dist/
	cp -a rootfs/ dist/rootfs
	mkdir -p dist/rootfs/bin
	cp -a build/micro/micro dist/rootfs/bin/

torcx.tgz: torcx
	cd dist && tar -C rootfs -czf micro.torcx.tgz .

torcx.squashfs: torcx
	cd dist && mksquashfs rootfs micro.torcx.squashfs -comp gzip 