#!/usr/bin/bash
set -e

BASE_DIR=$(pwd)

export TOOLCHAIN="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64"
export TARGET="aarch64-linux-android"
export API="33"
export AR="$TOOLCHAIN/bin/llvm-ar"
export CC="$TOOLCHAIN/bin/$TARGET$API-clang"
export CXX="$TOOLCHAIN/bin/$TARGET$API-clang++"
export OPENCV_LINK_LIBS="opencv_core"
export OPENCV_LINK_PATHS="$BASE_DIR/opencv/build-arm64-v8a/install/sdk/native/staticlibs/arm64-v8a"
export OPENCV_INCLUDE_PATHS="$BASE_DIR/opencv/build-arm64-v8a/install/sdk/native/jni/include"

RUST_BACKTRACE=full cargo ndk -t arm64-v8a -o ../app/src/main/jniLibs/  build -vv --release
#RUST_BACKTRACE=full cargo build -vv --target aarch64-linux-android
