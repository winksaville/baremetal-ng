# Copyright 2015 wink saville
#
# licensed under the apache license, version 2.0 (the "license");
# you may not use this file except in compliance with the license.
# you may obtain a copy of the license at
#
#     http://www.apache.org/licenses/license-2.0
#
# unless required by applicable law or agreed to in writing, software
# distributed under the license is distributed on an "as is" basis,
# without warranties or conditions of any kind, either express or implied.
# see the license for the specific language governing permissions and
# limitations under the license.

MK_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
CUR_DIR := $(notdir $(patsubst %/,%,$(dir $(MK_PATH))))

CC_FLAVOR ?= i386
LK_FLAVOR ?= i386
BITNESS ?= 32

CC=$(CC_FLAVOR)-unknown-elf-gcc
LK=$(LK_FLAVOR)-unknown-elf-gcc

CFLAGS:=-m$(BITNESS) -std=c11 -ffreestanding -O2 -g -static -Wall -Wextra -nostdlib -nostartfiles -nodefaultlibs

kmain.elf: boot.o kmain.o link.ld
	$(LK) $(CFLAGS) -Wl,-T,link.ld -o kmain.elf boot.o kmain.o -lgcc

boot.o: boot.S
	$(CC) $(CFLAGS) -c boot.S -o boot.o

kmain.o: kmain.c
	$(CC) $(CFLAGS) -c kmain.c -o kmain.o

.PHONY: run
run: kmain.elf
	qemu-system-i386 -kernel kmain.elf -nographic

.PHONY: clean
clean:
	rm -f boot.o kmain.o kmain.elf
