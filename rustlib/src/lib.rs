#![allow(non_snake_case)]


use jni::JNIEnv;
use jni::sys::jint;
use jni::objects::{JClass, JString, JObject};
use ndk::bitmap::{AndroidBitmap, AndroidBitmapInfo};
use log::info;
use opencv::{highgui, imgcodecs, imgproc, prelude::*};
use opencv::core::Mat;
use opencv::core::CV_VERSION;


#[no_mangle]
pub extern "system" fn Java_com_os_androidrustcvcam_MainActivityKt_opencvVersion<'local>(
     env: JNIEnv<'local>,
    _class: JClass<'local>,
) -> JString<'local> {

    // Get opencv version
    let version = CV_VERSION;
    env.new_string(version).unwrap()
}


pub extern "system" fn Java_com_os_androidrustcvcam_MainActivityKt_readBitmapWidth<'local>(
    env: JNIEnv<'local>,
    _class: JClass<'local>,
    mut _bitmap: JObject,
) -> jint {

    let _res: AndroidBitmap = unsafe { AndroidBitmap::from_jni(
        env.get_native_interface(), 
        *_bitmap) };

    let bmp_info: AndroidBitmapInfo = _res.get_info().expect("Failed to get bitmap info");
    let width: i32 = bmp_info.width() as i32;

    width
}

