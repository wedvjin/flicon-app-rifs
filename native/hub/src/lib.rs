use std::sync::{Arc, Mutex};

use bridge::respond_to_dart;
use web_alias::*;
use with_request::handle_request;

mod bridge;
mod messages;
mod sample_functions;
mod web_alias;
mod with_request;

/// This `hub` crate is the entry point for the Rust logic.
/// Always use non-blocking async functions such as `tokio::fs::File::open`.
async fn main() {

    let mut device = sample_crate::DeviceState::new();
    device.set_report_internal();
    let adevice = Arc::new(Mutex::new(device));
    // This is `tokio::sync::mpsc::Reciver` that receives the requests from Dart.
    let mut request_receiver = bridge::get_request_receiver();
    // Repeat `crate::spawn` anywhere in your code
    // if more concurrent tasks are needed.
    // crate::spawn(sample_functions::stream_mandelbrot());
    // crate::spawn(sample_functions::stream_increasing_number()); // ADD THIS LINE
    // crate::spawn(sample_functions::run_debug_tests());
    crate::spawn(sample_functions::stream_report_feature(adevice.clone()));
    crate::spawn(sample_functions::stream_report_in(adevice.clone())); // ADDed THIS LINE
    while let Some(request_unique) = request_receiver.recv().await {
        let adevice_cp = adevice.clone();
        crate::spawn(async {
            let response_unique = handle_request(request_unique, adevice_cp).await;
            respond_to_dart(response_unique);
        });
    }
}
