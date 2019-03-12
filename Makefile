RM = rm -rf
CWD ?= $(shell pwd)
KCC ?= konanc
KLIB ?= klib
MKDIR = mkdir -p
INSTALL ?= install
PKGCONF ?= libuv/libuv.pc
CFLAGS += $(shell pkg-config $(PKGCONF) --cflags)
LDFLAGS += $(shell pkg-config $(PKGCONF) --libs)

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
	if test -f libuv/Makefile; then $(MAKE) clean -C libuv; fi
	rm -f uv.def

uv.klib: uv.def lib/libuv.a
	cinterop -compilerOpts '$(CFLAGS)' -linkerOpts '-lpthread' -linkerOpts '$(LDFLAGS)' -def uv.def -o uv

uv.def: uv.def.in
	./configure

lib/libuv.a: libuv
	./configure
	$(MAKE) -C libuv
	$(MAKE) install -C libuv

libuv:
	git submodule update --recursive --init
