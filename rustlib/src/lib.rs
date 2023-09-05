#![cfg(target_os="android")]
#![allow(non_snake_case)]

use jni::JNIEnv;
use jni::objects::{JClass, JString};


// https://doc.rust-lang.org/reference/items/external-blocks.html#abi
#[no_mangle]
pub extern "system" fn Java_com_os_androidrustcvcam_MainActivityKt_opencvVersion<'local>(
    mut env: JNIEnv<'local>,
    _class: JClass<'local>,
) -> JString<'local> {

    // Get opencv version
    let version = opencv::core::CV_VERSION;
    env.new_string(version).unwrap()
}

