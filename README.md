# baremetal-i386

A a minimal bare metal program that runs on qemu-system-i386
it outputs "OK\n" to a COM1 at 0x3f8

License
---
[Apache 2.0 license](http://www.apache.org/licenses/).

Sources
---
Get the sources for this project from github.
```
mkdir -p ~/prgs
cd ~/prgs
git clone https://github.com/winksaville/baremetal-ng.git
cd baremetal-ng
```

Create crosstool chain using crosstool-ng. Modified as desired
---
 - ct-ng will be in /home/wink/opt/bin
 - i386-unknown-elf-xxx tools be in ~/x-tools/i386-unkown-elf/bin
 - x86_64-unknown-elf-xxx tools be in ~/x-tools/x86_64-unkown-elf/bin
```
git clone https://github.com/crosstool-ng/crosstool-ng
cd crosstool-ng
./bootstrap
./configure --prefix=/home/wink/opt
make
make install
cd ..
mkdir -p i386-unknown-elf
cd i386-unknown-elf
cp ../config.i386-unknown-elf .config
ct-ng build
cd ..
mkdir -p x86_64-unknown-elf
cd x86_64-unknown-elf
cp ../config.x86_64-unknown-elf .config
ct-ng build
cd ..
```

Build and run
---
```
make run
```

Type 'ctrl-a' x to exit.
