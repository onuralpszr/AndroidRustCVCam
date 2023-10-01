#!/usr/bin/env zsh

set -e
BASE_DIR=$(pwd)

export DYLD_FALLBACK_LIBRARY_PATH="$(xcode-select --print-path)/Toolchains/XcodeDefault.xctoolchain/usr/lib/"
export TOOLCHAIN="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64"
export TARGET="arm64-v8a-linux-android"
export API="24"
export AR="$TOOLCHAIN/bin/llvm-ar"
export CC="$TOOLCHAIN/bin/$TARGET$API-clang"
export CXX="$TOOLCHAIN/bin/$TARGET$API-clang++"
export OPENCV_LINK_LIBS="opencv_core"
export OPENCV_LINK_PATHS="$BASE_DIR/opencv/build-arm64-v8a/install/sdk/native/staticlibs/arm64-v8a"
export OPENCV_INCLUDE_PATHS="$BASE_DIR/opencv/build-arm64-v8a/install/sdk/native/jni/include"
cargo ndk -t arm64-v8a -o ../app/src/main/jniLibs/  build -vv --release
