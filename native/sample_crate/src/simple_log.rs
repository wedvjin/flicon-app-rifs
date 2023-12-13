use std::fs::OpenOptions;
use std::io::Write;
use std::io::Result;

pub fn append_to_file_log(filename: &str, value: &str) -> Result<()> {
    let mut file = OpenOptions::new()
        .create(true)  // Create file if it doesn't exist
        .append(true)  // Open file in append mode
        .open(filename)?;

    writeln!(file, "{}", value)?;
    Ok(())
}