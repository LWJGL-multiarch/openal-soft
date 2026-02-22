#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# sudo apt install cmake build-essential ninja-build libpulse-dev portaudio19-dev libasound2-dev libjack-dev libdbus-1-dev libpipewire-0.3-dev

cmake -B build \
    -G Ninja \
    -DALSOFT_REQUIRE_RTKIT=ON \
    -DALSOFT_REQUIRE_ALSA=ON \
    -DALSOFT_REQUIRE_OSS=ON \
    -DALSOFT_REQUIRE_PORTAUDIO=ON \
    -DALSOFT_REQUIRE_PULSEAUDIO=ON \
    -DALSOFT_REQUIRE_JACK=ON \
    -DALSOFT_REQUIRE_PIPEWIRE=ON \
    -DALSOFT_EMBED_HRTF_DATA=YES \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_FLAGS:STRING="-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=0"
cmake --build build --parallel
strip ./build/libopenal.so

# Copy result to output directory
LWJGL_OUTPUT_DIR="${LWJGL_OUTPUT_DIR:-/tmp/lwjgl3-build/output}"

mkdir -p "$LWJGL_OUTPUT_DIR"
cp ./build/libopenal.so "$LWJGL_OUTPUT_DIR/libopenal.so"
