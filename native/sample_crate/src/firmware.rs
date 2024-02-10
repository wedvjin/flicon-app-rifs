
use std::process::Command;
use std::os::windows::process::CommandExt;

use crate::simple_log::append_to_file_log;

// pub fn upgrade_firmware_bat(path: String) -> String {

//     let status = Command::new("base_update.bat")
//         .arg(path) // Pass the path as an argument
//         .status()
//         .expect("Failed to run script");

//     return "on".to_string();
// }

// #[no_mangle]
// extern "C" {
//     fn fwup(
//         dll_name: *const i8,
//         filePath: *const u16,
//     ) -> i32;
// }

// use std::ffi::{CString, OsStr};
// use std::os::windows::ffi::OsStrExt;

// fn call_c_main(dll_name: &str, file_path: &OsStr) -> i32 {
//     let dll_name_c = CString::new(dll_name).expect("CString::new failed");
//     let file_path_wide: Vec<u16> = file_path.encode_wide().chain(std::iter::once(0)).collect();

//     unsafe {
//         fwup(dll_name_c.as_ptr(), file_path_wide.as_ptr())
//     }
// }



// pub fn upgrade_firmware_lib(path: String) -> String {

//     call_c_main("CubeProgrammer_API.dll", OsStr::new(&path));

//     return "on".to_string();
// }

use std::process::{Stdio};
use std::fs::File;

const CREATE_NO_WINDOW: u32 = 0x08000000;

pub fn upgrade_firmware(path: String) -> String {

    let output_file = File::create("fwUpdateResult.txt").expect("Failed to create output file");

    let status = Command::new("fwup.exe")
        .arg("CubeProgrammer_API.dll")
        .arg(path.clone()) // Pass the path as an argument
        // .creation_flags(CREATE_NO_WINDOW)
        .stdout(Stdio::from(output_file)) // Redirect stdout to the file
        .status()
        .expect("Failed to run script");

    // append_to_file_log("log.log", &status.to_string());
    // append_to_file_log("log.log", &path);

    println!("FWUP status: {:?}", status);
    return "status".to_string();
}