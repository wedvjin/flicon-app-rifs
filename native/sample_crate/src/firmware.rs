
use std::process::Command;

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

pub fn upgrade_firmware(path: String) -> String {

    let status = Command::new("fwup.exe")
        .arg("CubeProgrammer_API.dll")
        .arg(path) // Pass the path as an argument
        .status()
        .expect("Failed to run script");

    println!("FWUP status: {:?}", status);
    return "status".to_string();
}