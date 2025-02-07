#!/usr/bin/env bash

set -ex

# Download
version=3360000
URL="https://www.sqlite.org/2021/sqlite-autoconf-$version.tar.gz"
pushd "${DOWNLOADS}"
wget -N "$URL"
popd

# Extract
tar xzf "${DOWNLOADS}/sqlite-autoconf-$version.tar.gz"
pushd sqlite-autoconf-$version

# Configure
. cross-pkg-config
./configure \
        --prefix="/usr/local" \
        --host="${HOST_TRIPLE}"

# Build
make -j$(($(nproc) * 2))

# Install
make install DESTDIR="${RPI_SYSROOT}"
make install DESTDIR="${RPI_STAGING}"

# Cleanup
popd
rm -rf sqlite-autoconf-$version