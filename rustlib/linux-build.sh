#!/usr/bin/bash
set -e

if [ ! -n "$ANDROID_NDK_HOME" ]
then
  echo "Please set the ANDROID_NDK_HOME variable!"
  exit 1
fi

cargo update
rustup target add \
    aarch64-linux-android \
    armv7-linux-androideabi \
    x86_64-linux-android \
    i686-linux-android

cargo install cargo-ndk

BASE_DIR=$(pwd)


# Build OpenCV

if [ ! -d "opencv" ]; then
  git clone -b 4.8.0 --depth 1 https://github.com/opencv/opencv.git
fi


(
    cd opencv

    for i in armeabi-v7a arm64-v8a x86 x86_64
    do
        rm -rf build-${i}
        mkdir -p build-${i}
        cd build-${i}
        cmake \
                -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake \
                -DCMAKE_INSTALL_PREFIX=$BASE_DIR/opencv/build-${i}/install \
                -DCMAKE_BUILD_TYPE=Release \
                -DCMAKE_SYSTEM_NAME=Android \
                -DBUILD_LIST=core,features2d,imgproc,highgui,imgcodecs,photo,video \
                -DBUILD_SHARED_LIBS=NO \
                -DANDROID_ABI="${i}" \
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

        make -j16
        make install
        cd ..
    done
)


RUST_BACKTRACE=full


rm -rf Cargo.lock target
export TOOLCHAIN="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64"
export TARGET="aarch64-linux-android"
export API="24"
export AR="$TOOLCHAIN/bin/llvm-ar"
export CC="$TOOLCHAIN/bin/$TARGET$API-clang"
export CXX="$TOOLCHAIN/bin/$TARGET$API-clang++"
export OPENCV_LINK_LIBS="opencv_core"
export OPENCV_LINK_PATHS="$BASE_DIR/opencv/build-arm64-v8a/install/sdk/native/staticlibs/arm64-v8a"
export OPENCV_INCLUDE_PATHS="$BASE_DIR/opencv/build-arm64-v8a/install/sdk/native/jni/include"
cargo ndk -t arm64-v8a -o ../app/src/main/jniLibs/  build -vv --release


rm -rf Cargo.lock target
export TOOLCHAIN="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64"
export TARGET="armv7a-linux-android"
export API="24"
export AR="$TOOLCHAIN/bin/llvm-ar"
export CC="$TOOLCHAIN/bin/$TARGET$API-clang"
export CXX="$TOOLCHAIN/bin/$TARGET$API-clang++"
export OPENCV_LINK_LIBS="opencv_core"
export OPENCV_LINK_PATHS="$BASE_DIR/opencv/build-armeabi-v7a/install/sdk/native/staticlibs/armeabi-v7a"
export OPENCV_INCLUDE_PATHS="$BASE_DIR/opencv/build-armeabi-v7a/install/sdk/native/jni/include"
cargo ndk -t armeabi-v7a -o ../app/src/main/jniLibs/  build -vv --release

rm -rf Cargo.lock target
export TOOLCHAIN="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64"
export TARGET="i686-linux-android"
export API="24"
export AR="$TOOLCHAIN/bin/llvm-ar"
export CC="$TOOLCHAIN/bin/$TARGET$API-clang"
export CXX="$TOOLCHAIN/bin/$TARGET$API-clang++"
export OPENCV_LINK_LIBS="opencv_core"
export OPENCV_LINK_PATHS="$BASE_DIR/opencv/build-x86/install/sdk/native/staticlibs/x86"
export OPENCV_INCLUDE_PATHS="$BASE_DIR/opencv/build-x86/install/sdk/native/jni/include"
cargo ndk -t x86 -o ../app/src/main/jniLibs/  build -vv --release

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
