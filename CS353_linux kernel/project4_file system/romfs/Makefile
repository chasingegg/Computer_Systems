#
# Makefile for the linux RomFS filesystem routines.
#

obj-$(CONFIG_ROMFS_FS) += romfs.o

romfs-y := storage.o super.o
KDIR := /lib/modules/$(shell uname -r)/build
EXTRA_FLAGS := -I(PWD)
PWD := $(shell pwd)

ifneq ($(CONFIG_MMU),y)
romfs-$(CONFIG_ROMFS_ON_MTD) += mmap-nommu.o
endif

all:
	make -C $(KDIR) M=$(PWD) modules
clean:
	make -C $(KDIR) M=$(PWD) clean
