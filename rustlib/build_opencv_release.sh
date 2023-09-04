#!/usr/bin/bash
set -e

cargo update
rustup target add \
    aarch64-linux-android \
    armv7-linux-androideabi \
    x86_64-linux-android \
    i686-linux-android

cargo install cargo-ndk

BASE_DIR=$(pwd)


(
    cd opencv
    rm -rf build-arm64-v8a
    mkdir -p build-arm64-v8a
    cd build-arm64-v8a
    cmake \
            -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake \
            -DCMAKE_INSTALL_PREFIX=$BASE_DIR/opencv/build-arm64-v8a/install \
            -DCMAKE_BUILD_TYPE=Release \
            -DCMAKE_SYSTEM_NAME=Android \
            -DBUILD_LIST=core,features2d,imgproc,highgui,photo,video \
            -DBUILD_SHARED_LIBS=NO \
            -DANDROID_ABI="arm64-v8a" \
            -DANDROID_PLATFORM=android-24 \
            -DANDROID_USE_LEGACY_TOOLCHAIN_FILE=False \
            -DBUILD_ANDROID_EXAMPLES=OFF \
            -DBUILD_ANDROID_PROJECTS=OFF \
            -DBUILD_DOCS=OFF \
            -DBUILD_KOTLIN_EXTENSIONS=OFF \
            -DBUILD_FAT_JAVA_LIB=OFF \
            -DBUILD_PERF_TESTS=OFF \
            -DBUILD_TESTS=OFF \
            -DBUILD_opencv_java=OFF \
            -DBUILD_opencv_python=OFF \
            -DANDROID_ARM_NEON=TRUE \
            -DBUILD_opencv_python2=OFF \
            -DINSTALL_C_EXAMPLES=OFF \
            -DINSTALL_PYTHON_EXAMPLES=OFF \
            -DENABLE_BITCODE=OFF \
            -DWITH_CUDA=OFF \
            -DWITH_MATLAB=OFF \
            -DANDROID_STL="c++_static" \
            ..

    make -j12
    make install
)

rm -rf Cargo.lock target
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
