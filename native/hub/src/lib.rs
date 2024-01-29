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
    
    let _guard = sentry::init(("https://1354173b08a55b6adbb7d635509183ed@o4506654064574464.ingest.sentry.io/4506654065426432", sentry::ClientOptions {
        release: sentry::release_name!(),
        ..Default::default()
    }));

    sentry::capture_message("Hello World!", sentry::Level::Info);
    let mut device = sample_crate::DeviceState::new();



    // device.set_report_internal();
    let adevice = Arc::new(Mutex::new(device));
    // This is `tokio::sync::mpsc::Reciver` that receives the requests from Dart.
    let mut request_receiver = bridge::get_request_receiver();
    // Repeat `crate::spawn` anywhere in your code
    // if more concurrent tasks are needed.
    crate::spawn(sample_functions::stream_report(adevice.clone()));
    // crate::spawn();
    while let Some(request_unique) = request_receiver.recv().await {
        let adevice_cp = adevice.clone();
        crate::spawn(async move {
            let response_unique = handle_request(request_unique, adevice_cp).await;
            respond_to_dart(response_unique);
        });
    }
}
