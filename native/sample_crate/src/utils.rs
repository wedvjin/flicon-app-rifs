use std::{io::{self, Read}, env, path::PathBuf};
use anyhow::Result;

pub fn get_current_dir() -> io::Result<PathBuf> {
    // Get and return the current directory
    env::current_dir()
}

pub fn get_username() -> Result<String> {
    let username = env::var("USERNAME").unwrap();
    Ok(username)
}

