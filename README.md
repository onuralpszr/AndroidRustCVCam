<h1 align="center">Android RustCVCam</h1>

Android's Jetpack Compose with Rust and OpenCV by using Android Camera

<p>
  <img alt="GitHub" src="https://img.shields.io/github/license/onuralpszr/AndroidRustCVCam">
  <a href="https://conventionalcommits.org"><img alt="Conventional Commits" src="https://img.shields.io/badge/Conventional%20Commit-1.0.0-FE5196?logo=conventionalcommits&logoColor=white"></a>
</p>


## Prerequisites

- Rust 1.55.0 or later
- Cargo 1.55.0 or later
- Android SDK
- Android NDK >= r23

## Getting Started

1. Clone the repository:

```console
git clone https://github.com/onuralpszr/AndroidRustCVCam
```

2. Open the project in Android Studio.

3. Build the Rust code:

For arm64-v8a

```console
cd rustlib
cargo update
rustup target add aarch64-linux-android
cargo install cargo-ndk
cargo ndk -t arm64-v8a -o ../app/src/main/jniLibs/  build
```

or build for all architectures

```console
cd rustlib
./build.sh
```

4. Build and run the app in Android Studio with your emulator or in device.


## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
