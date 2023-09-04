#!/usr/bin/bash

set -e
BASE_DIR=$(pwd)

rm -rf Cargo.lock target
export TOOLCHAIN="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64"
export TARGET="x86_64-linux-android"
export API="24"
export AR="$TOOLCHAIN/bin/llvm-ar"
export CC="$TOOLCHAIN/bin/$TARGET$API-clang"
export CXX="$TOOLCHAIN/bin/$TARGET$API-clang++"
export OPENCV_LINK_LIBS="opencv_core"
export OPENCV_LINK_PATHS="$BASE_DIR/opencv/build-x86_64/install/sdk/native/staticlibs/x86_64"
export OPENCV_INCLUDE_PATHS="$BASE_DIR/opencv/build-x86_64/install/sdk/native/jni/include"
cargo ndk -t x86_64 -o ../app/src/main/jniLibs/  build -vv --release