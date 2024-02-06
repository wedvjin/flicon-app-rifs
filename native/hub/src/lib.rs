use std::sync::{Arc, Mutex};
use sample_crate::DeviceState;
use tokio::select;
use tokio::sync::mpsc;

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

    sentry::capture_message("Hello World from testing device!", sentry::Level::Info);

    // let (tx, rx) = mpsc::channel(32);

    let mut device = sample_crate::DeviceState::new();



    // device.set_report_internal();
    let adevice = Arc::new(Mutex::new(device));
    crate::spawn(device_monitor(adevice.clone()));
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

// extern crate hidapi;
use hidapi::{DeviceInfo, HidDevice};
const VENDOR_ID_CONST: u16 = 13911;
async fn device_monitor(
    adevice: Arc<Mutex<DeviceState>>,
) {
    loop {
        let api = hidapi::HidApi::new().unwrap();
        let device_info_res = api
            .device_list()
            .into_iter()
            .find(|&device| device.vendor_id() == VENDOR_ID_CONST);

        let count = api.device_list()
            .filter(|device_info| device_info.vendor_id() == VENDOR_ID_CONST)
            .count();

        if count >= 2 {
            // println!("More than 2 devices connected");
            let mut device = adevice.lock().unwrap();
            device.more_than_two = true;
        } else if count == 1 {
            let mut device = adevice.lock().unwrap();
            device.more_than_two = false;
        }
        // else if count == 0 {
        //     let mut device = adevice.lock().unwrap();
        //     device.connected = false;
        // }
        // keep count and reference of currently connected devices
        
        // if any device is disconnected, remove it from the list
        // if any device is connected, add it to the list

        // keep number of connected devices updated
        tokio::time::sleep(tokio::time::Duration::from_secs(1)).await;
    }
}