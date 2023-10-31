use std::{io::{self, Read}, env, path::PathBuf};
use anyhow::Result;

pub fn get_current_dir() -> io::Result<PathBuf> {
    // Get and return the current directory
    env::current_dir()
}

pub fn get_username() -> Result<String> {
    #[cfg(target_os = "windows")]
    let username = env::var("USERNAME").unwrap();
    #[cfg(target_os = "macos")]
    let username = env::var("USER").unwrap();
    Ok(username)
}

pub fn get_profiles_path() -> Result<PathBuf> {
    let username = get_username().unwrap();

    #[cfg(target_os = "windows")]
    let base_path = "C:\\Users";

    #[cfg(target_os = "macos")]
    let base_path = "/Users/";

    #[cfg(target_os = "windows")]
    let dir_path = PathBuf::from(format!("{}\\{}\\Documents\\FCTechnologies", base_path, username));

    #[cfg(target_os = "macos")]
    let dir_path = PathBuf::from(format!("{}/{}/FCTechnologies/", base_path, username));

    #[cfg(debug_assertions)]
    println!("dir_path: {:?}", dir_path);

    Ok(dir_path)
}
