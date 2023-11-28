
use std::process::Command;

pub fn upgrade_firmware(path: String) -> String {

    let status = Command::new("base_update.bat")
        .arg(path) // Pass the path as an argument
        .status()
        .expect("Failed to run script");

    return "on".to_string();
}