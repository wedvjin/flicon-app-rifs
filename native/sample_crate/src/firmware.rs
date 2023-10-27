extern crate libloading;

use libloading::{Library, Symbol};
use std::{io::{self, Read}, env, path::PathBuf, ffi::{OsStr, c_char, CString}, os::windows::prelude::OsStrExt, fs::File};

use crate::utils::{get_current_dir, get_username};

pub fn upgrade_firmware(path: String) {
    let current_dir = get_current_dir().unwrap();
    println!("current_dir: {:?}", current_dir);
    let username = get_username().unwrap();

    // #[cfg(not(debug_assertions))]
    let complete_path = current_dir.join("stm32\\CubeProgrammer_API.dll");

    // #[cfg(debug_assertions)]
    // let complete_path = PathBuf::from(format!("C:\\Users\\{}\\source\\repos\\flicon-app-rif\\flicon\\stm32\\CubeProgrammer_API.dll", username));
    //C:\Users\Viktor\source\repos\flicon-app-rif\flicon\stm32

    println!("path to dll: {:?}", complete_path);

    // let file_path = "C:\\Users\\Viktor\\Downloads\\FLICON_base_2.0.hex";
    
    // TODO: take the same name of the latest version

    #[cfg(debug_assertions)]
    let mut file_path = PathBuf::from(format!("C:\\Users\\{}\\Downloads\\FLICON_base_2.0.hex", username));
    let mut file_path = PathBuf::from(path);

    let os_str: &OsStr = OsStr::new(&file_path);
    let mut wide_string: Vec<u16> = os_str.encode_wide().collect();
    wide_string.push(0); // Null-terminate the wide string
    
    let wide_string_ptr: *const u16 = wide_string.as_ptr();

    unsafe {
        let lib = Library::new(complete_path).expect("Could not load the DLL");

        let upgrade_fw: Symbol<DownloadFirmwareFunction> = lib.get(b"downloadFile")
            .expect("Could not find the function in the DLL");
        type DownloadFirmwareFunction = unsafe fn(file_path: *const u16, address: u32, skip_erase: u32, verify: u32, binPath: *const u16) -> u32;

        let address = 0x08008000;
        let skip_erase = 0; // to not skip erasing
        let verify = 1;
        let bin_path: *const u16 = std::ptr::null();
        println!("FW upgrade started");
        std::thread::sleep(std::time::Duration::from_millis(5000));

        let result = upgrade_fw(wide_string_ptr, address, skip_erase, verify, bin_path);

        println!("FW upgrade result: {}", result);
        std::thread::sleep(std::time::Duration::from_millis(2000));

        let func_execute: Symbol<ExecuteFunction> = lib.get(b"execute")
            .expect("Could not find the function in the DLL");

        type ExecuteFunction = unsafe fn(address: u32) -> u32;

        let result = func_execute(address);

        println!("Execute result: {}", result);

    }

}

// fn get_firmware_hex(file_path: PathBuf) -> 

// pub fn upgrade_firmware() {
//     match env::current_dir() {
//         Ok(path) => {
//             println!("The current directory is: {}", path.display());
//         }
//         Err(e) => {
//             println!("An error occurred while getting the current directory: {}", e);
//         }
//     }
//     unsafe {
//         // Load the DLL
//         let lib = Library::new("path_to_your_dll.dll").expect("Could not load the DLL");
        
//         // Define the function signature you want to call
//         #[allow(dead_code)]
//         type YourFunction = unsafe fn(arg1: i32, arg2: i32) -> i32;
        
//         // Get the function symbol from the DLL
//         let func: Symbol<YourFunction> = lib.get(b"your_function_name")
//             .expect("Could not find the function in the DLL");
        
//         // Call the function
//         let result = func(1, 2);
        
//         println!("Function result: {}", result);
//     }
// }

// // extern crate libc;
// // extern crate winapi;

// // use libc::c_int;
// // use std::ffi::OsStr;
// // use std::os::windows::ffi::OsStrExt;
// // use std::ptr;
// // use winapi::ctypes::c_void;
// // use winapi::um::libloaderapi::{GetModuleHandleW, GetProcAddress};

// // fn main() {
// //     // Convert the function name to a wide string because Windows API expects it
// //     let function_name = OsStr::new("firmwareUpgrade")
// //         .encode_wide()
// //         .chain(std::iter::once(0))
// //         .collect::<Vec<u16>>();

// //     // Load the DLL
// //     let h_module = unsafe { GetModuleHandleW(ptr::null()) };
// //     if h_module.is_null() {
// //         println!("Failed to get module handle.");
// //         return;
// //     }

// //     // Get the procedure address
// //     let func: Option<unsafe extern "C" fn(
// //         *const u16,
// //         c_int,
// //         c_int,
// //         c_int,
// //         c_int,
// //     ) -> c_int> = unsafe {
// //         let proc_address = GetProcAddress(h_module, function_name.as_ptr());
// //         if proc_address.is_null() {
// //             None
// //         } else {
// //             Some(std::mem::transmute(proc_address))
// //         }
// //     };

// //     match func {
// //         Some(firmware_upgrade) => {
// //             let result = unsafe {
// //                 firmware_upgrade(
// //                     // Put your parameters here
// //                     // For example:
// //                     // path to your firmware file as *const u16,
// //                     // address as c_int,
// //                     // firstInstall as c_int,
// //                     // startStack as c_int,
// //                     // verify as c_int
// //                 )
// //             };

// //             println!("Function executed, result: {}", result);
// //         }
// //         None => println!("Failed to get the procedure address."),
// //     }
// // }