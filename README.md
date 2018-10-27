datkt.uv
========

libuv bindings for Kotlin/Native.

## Installation

The `uv` package an be installed with various package managers.

### From NPM

```sh
$ npm install @datkt/uv
```

**Note:** *This will install **uv** into `node_modules/@datkt/uv`*

### Install From Source

```sh
$ git clone git@github.com:datkt/uv.git
$ cd uv
$ make build # or make klib
$ make install
```

## Prerequisites

* [Kotlin/Native](https://github.com/JetBrains/kotlin-native) and the
  `konanc` command line program.
* [make](https://www.gnu.org/software/make/)

## Usage

```sh
## Compile a program in 'main.kt' and link uv.klib found in node_modules
$ konanc -l "$(find node_modules -name uv.klib)" main.kt
```

where `main.kt` might be

```kotlin
import datkt.uv.* // entire libuv API
import kotlinx.cinterop.* // exposes types needed for interop

fun main(args: Array<String>) {
  if (0 != uv_init()) {
    throw Error("Failed to initialize libuv")
  }
}
````

## Example

```kotlin
import kotlinx.cinterop.*
import datkt.uv.uv_init
import datkt.uv.randombytes_buf
import datkt.uv.randombytes_random
import datkt.uv.randombytes_uniform

fun main(args: Array<String>) {
  val rc = uv_init()

  if (0 != rc) {
    throw Error("uv_init() != 0")
  }
}
```

## libuv API

This package binds libuvs entire API and provides an
[interop](https://github.com/JetBrains/kotlin-native/blob/master/INTEROP.md)
API for Kotlin and can be imported from the `uv` package.

## Building

The `uv` package can be built from source into various targets.

### Kotlin Library

`uv.klib`, a Kotlin library that can be linked with `konanc` can be
built from source.

```sh
$ make klib
```

which will produce `build/lib/uv.klib`. The library can be installed
with `klib` by running `make install`

### Static Library

`libuv.a`, a static library that can be linked with `konanc` can be
built from source.

```sh
$ make static
```

which will produce `build/lib/libuv.a` and C header files in
`build/include`. The library can be installed into your system by
running `make install`. The path prefix can be set by defining the
`PREFIX` environment or `make` variable. It defaults to
`PREFIX=/usr/local`

## See Also

* https://libuv.gitbook.io/doc
* https://github.com/jedisct1/libuv
* https://github.com/uv-friends/uv-native

## License

MIT
