#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    cmake \
    sdl2

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini

echo "Building DingusPPC..."
echo "---------------------------------------------------------------"
REPO="https://github.com/dingusdev/dingusppc"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone --recursive --depth 1 "$REPO" ./dingusppc
echo "$VERSION" > ~/version

mkdir -p ./AppDir/bin
cd ./dingusppc
cmake -S ./ -B build -D CMAKE_BUILD_TYPE=Release
cmake --build build -j$(nproc)
mv -v ./build/bin/dingusppc ../AppDir/bin
