RM = rm -rf
CWD ?= $(shell pwd)
KCC ?= konanc
KLIB ?= klib
MKDIR = mkdir -p
INSTALL ?= install

OS ?= $(shell uname)
TEST ?= test/
NAME ?= uv
PREFIX ?= /usr/local

build: klib
klib: uv.klib
static: lib/libuv.a

install: build
	$(KLIB) install $(KOTLIN_LIBRARY)

uninstall:
	$(KLIB) remove $(NAME)

clean:
	$(RM) uv-build/ uv.klib META-INF lib tmp libuv.a include
	$(MAKE) clean -C examples
	if test -f libuv/Makefile; then $(MAKE) clean -C libuv; fi

uv.klib: uv.def lib/libuv.a
	cinterop -pkg datkt.uv -def uv.def -o uv

lib/libuv.a: libuv
	./configure
	$(MAKE) -C libuv
	$(MAKE) install -C libuv

libuv:
	git submodule update --recursive --init
