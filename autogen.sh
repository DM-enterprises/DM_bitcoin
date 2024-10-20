#!/bin/sh
# https://github.com/DM-enterprises/DM_bitcoin/
export LC_ALL=C
set -e
srcdir="$(dirname "$0")"
cd "$srcdir"
if [ -z "${LIBTOOLIZE}" ] && GLIBTOOLIZE="$(command -v glibtoolize)"; then
  LIBTOOLIZE="${GLIBTOOLIZE}"
  export LIBTOOLIZE
fi
command -v autoreconf >/dev/null || \
  (echo "configuration failed, please install autoconf first" && exit 1)
autoreconf --install --force --warnings=all

if expr "'$(build-aux/config.guess --timestamp)" \< "'$(depends/config.guess --timestamp)" > /dev/null; then
  chmod ug+w build-aux/config.guess
  chmod ug+w src/secp256k1/build-aux/config.guess
  cp depends/config.guess build-aux
  cp depends/config.guess src/secp256k1/build-aux
fi
if expr "'$(build-aux/config.sub --timestamp)" \< "'$(depends/config.sub --timestamp)" > /dev/null; then
  chmod ug+w build-aux/config.sub
  chmod ug+w src/secp256k1/build-aux/config.sub
  cp depends/config.sub build-aux
  cp depends/config.sub src/secp256k1/build-aux
fi
