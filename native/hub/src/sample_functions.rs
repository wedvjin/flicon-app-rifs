//! This module is only for demonstration purposes.
//! You might want to remove this module in production.

use std::sync::{Arc, Mutex};
use anyhow::Result as AResult;

use crate::bridge::api::{RustOperation, RustRequest, RustResponse, RustSignal};
use crate::bridge::send_rust_signal;
use crate::messages::device_info::SetValues;
use prost::Message;
use sample_crate::{DeviceState, ReportIn, ReportFeature};

pub async fn handle_sample_resource(rust_request: RustRequest) -> RustResponse {
    match rust_request.operation {
        RustOperation::Create => RustResponse::default(),
        RustOperation::Read => RustResponse::default(),
        RustOperation::Update => RustResponse::default(),
        RustOperation::Delete => RustResponse::default(),
    }
}

pub async fn handle_deeper_resource(rust_request: RustRequest) -> RustResponse {
    match rust_request.operation {
        RustOperation::Create => RustResponse::default(),
        RustOperation::Read => RustResponse::default(),
        RustOperation::Update => RustResponse::default(),
        RustOperation::Delete => RustResponse::default(),
    }
}

// pub async fn stream_report_feature(
//     device: Arc<Mutex<DeviceState>>,
// ) {
//     use crate::messages::report_feature_message::{ReportFeature, ID};

//     loop {

//         crate::sleep(std::time::Duration::from_millis(40)).await;
//         let report_feature_data = device.lock().unwrap().get_report();

//         let report_feature_signal_message = ReportFeature {
//             id: report_feature_data.id as u32,
//             x_min: report_feature_data.x_min as u32,
//             x_centr: report_feature_data._x_centr as u32,
//             x_max: report_feature_data.x_max as u32,
//             x_averaging: report_feature_data.x_averaging as u32,
//             x_dead_zone: report_feature_data.x_dead_zone as u32,
//             y_min: report_feature_data.y_min as u32,
//             y_centr: report_feature_data._y_centr as u32,
//             y_max: report_feature_data.y_max as u32,
//             y_averaging: report_feature_data.y_averaging as u32,
//             y_dead_zone: report_feature_data.y_dead_zone as u32,
//             z_min: report_feature_data.z_min as u32,
//             z_centr: report_feature_data._z_centr as u32,
//             z_max: report_feature_data.z_max as u32,
//             z_averaging: report_feature_data.z_averaging as u32,
//             z_dead_zone: report_feature_data.z_dead_zone as u32,
//             rx_min: report_feature_data.rx_min as u32,
//             rx_centr: report_feature_data._rx_centr as u32,
//             rx_max: report_feature_data.rx_max as u32,
//             rx_averaging: report_feature_data.rx_averaging as u32,
//             rx_dead_zone: report_feature_data.rx_dead_zone as u32,
//             ry_min: report_feature_data.ry_min as u32,
//             ry_centr: report_feature_data._ry_centr as u32,
//             ry_max: report_feature_data.ry_max as u32,
//             ry_averaging: report_feature_data.ry_averaging as u32,
//             ry_dead_zone: report_feature_data.ry_dead_zone as u32,
//             rz_min: report_feature_data.rz_min as u32,
//             rz_max: report_feature_data.rz_max as u32,
//             rz_averaging: report_feature_data.rz_averaging as u32,
//             rz_dead_zone: report_feature_data.rz_dead_zone as u32,
//             slider_min: report_feature_data.slider_min as u32,
//             slider_max: report_feature_data.slider_max as u32,
//             slider_averaging: report_feature_data.slider_averaging as u32,
//             slider_dead_zone: report_feature_data.slider_dead_zone as u32,
//             encoder_time: report_feature_data.encoder_time as u32,
//             led_r: report_feature_data.led_r as u32,
//             led_g: report_feature_data.led_g as u32,
//             led_b: report_feature_data.led_b as u32,
//             id_grib: report_feature_data.id_grib as u32,
//             hatka1_mode: report_feature_data.hatka1_mode as u32,
//             hatka2_mode: report_feature_data.hatka2_mode as u32,
//             hatka3_mode: report_feature_data.hatka3_mode as u32,
//             hatka4_mode: report_feature_data.hatka4_mode as u32,
//             control_byte: report_feature_data.control_byte as u32,
//             gash_button1_min: report_feature_data.gash_button1_min as u32,
//             gash_button1_max: report_feature_data.gash_button1_max as u32,
//             gash_button2_min: report_feature_data.gash_button2_min as u32,
//             gash_button2_max: report_feature_data.gash_button2_max as u32,
//             gash_button3_min: report_feature_data.gash_button3_min as u32,
//             gash_button3_max: report_feature_data.gash_button3_max as u32,
//             spi_error_cnt: report_feature_data.spi_error_cnt as u32,
//             buttons: report_feature_data.buttons as u64,
//             x_axis: report_feature_data.x_axis as u32,
//             y_axis: report_feature_data.y_axis as u32,
//             z_axis: report_feature_data.z_axis as u32,
//             rx_axis: report_feature_data.rx_axis as u32,
//             ry_axis: report_feature_data.ry_axis as u32,
//             rz_axis: report_feature_data.rz_axis as u32,
//             slider_axis: report_feature_data.slider_axis as u32,
//             fw_version: report_feature_data.fw_version as u32,
//         };

//         let rust_signal = RustSignal {
//             resource: ID,
//             message: Some(report_feature_signal_message.encode_to_vec()),
//             blob: None,
//         };

//         send_rust_signal(rust_signal);
//     }
// }

pub async fn stream_report(
    adevice: Arc<Mutex<DeviceState>>,
) {
    use crate::messages::report_message::{ID};
    use crate::messages::report_message::ReportMessage;
    use sample_crate::Buttons;

    loop {
        crate::sleep(std::time::Duration::from_millis(40)).await;

        let mut device_state = adevice.lock().unwrap();

        if !device_state.connected {
            DeviceState::reinst();
        }

        let report_in_data_res = device_state.get_data();
        let report_in_data: ReportIn = match report_in_data_res {
            Ok(data) => {
                device_state.connected = true;
                data
            },
            Err(err) => {
                device_state.connected = false;
                ReportIn {
                    ..Default::default()
                }
            }
        };


        let buttons = Buttons::new(report_in_data.buttons);
        // println!("BUTTONS: {:?}", buttons);
        // println!("{:#048b}", report_in_data.buttons);
        // crate::sleep(std::time::Duration::from_millis(40)).await;

        // let report_feature_data = adevice.lock().unwrap().get_report();
        let report_feature_data_res = device_state.get_report();
        let report_feature_data: ReportFeature = match report_feature_data_res {
            Ok(data) => {
                device_state.connected = true;
                data
            },
            Err(err) => {
                device_state.connected = false;
                ReportFeature {
                    ..Default::default()
                }
            }
        };

        let report_in_signal_message = ReportMessage {
            connected: device_state.connected,
            id: report_in_data.id as u32,
            buttons: report_in_data.buttons as u64,
            x: report_in_data.x_axis as u32,
            y: report_in_data.y_axis as u32,
            z: report_in_data.z_axis as u32,
            rx: report_in_data.rx_axis as u32,
            ry: report_in_data.ry_axis as u32,
            rz: report_in_data.rz_axis as u32,
            slider: report_in_data.slider_axis as u32,

            b1: buttons.b1 as bool,
            b2: buttons.b2 as bool,
            b3: buttons.b3 as bool,
            b4: buttons.b4 as bool,
            b5: buttons.b5 as bool,
            b6: buttons.b6 as bool,
            b7: buttons.b7 as bool,
            b8: buttons.b8 as bool,
            b9: buttons.b9 as bool,
            b10: buttons.b10 as bool,
            b11: buttons.b11 as bool,
            b12: buttons.b12 as bool,
            b13: buttons.b13 as bool,
            b14: buttons.b14 as bool,
            b15: buttons.b15 as bool,
            b16: buttons.b16 as bool,
            b17: buttons.b17 as bool,
            b18: buttons.b18 as bool,
            b19: buttons.b19 as bool,
            b20: buttons.b20 as bool,
            b21: buttons.b21 as bool,
            b22: buttons.b22 as bool,
            b23: buttons.b23 as bool,
            b24: buttons.b24 as bool,
            b25: buttons.b25 as bool,
            b26: buttons.b26 as bool,
            b27: buttons.b27 as bool,
            b28: buttons.b28 as bool,
            b29: buttons.b29 as bool,
            b30: buttons.b30 as bool,
            b31: buttons.b31 as bool,
            b32: buttons.b32 as bool,
            b33: buttons.b33 as bool,
            b34: buttons.b34 as bool,
            b35: buttons.b35 as bool,
            b36: buttons.b36 as bool,
            b37: buttons.b37 as bool,
            b38: buttons.b38 as bool,
            b39: buttons.b39 as bool,
            b40: buttons.b40 as bool,
            b41: buttons.b41 as bool,
            b42: buttons.b42 as bool,
            b43: buttons.b43 as bool,
            b44: buttons.b44 as bool,
            b45: buttons.b45 as bool,
            b46: buttons.b46 as bool,
            b47: buttons.b47 as bool,
            b48: buttons.b48 as bool,
            b49: buttons.b49 as bool,

            fid: report_feature_data.id as u32,
            x_min: report_feature_data.x_min as i32,
            x_centr: report_feature_data._x_centr as i32,
            x_max: report_feature_data.x_max as i32,
            x_averaging: report_feature_data.x_averaging as u32,
            x_dead_zone: report_feature_data.x_dead_zone as u32,
            y_min: report_feature_data.y_min as i32,
            y_centr: report_feature_data._y_centr as i32,
            y_max: report_feature_data.y_max as i32,
            y_averaging: report_feature_data.y_averaging as u32,
            y_dead_zone: report_feature_data.y_dead_zone as u32,
            z_min: report_feature_data.z_min as i32,
            z_centr: report_feature_data._z_centr as i32,
            z_max: report_feature_data.z_max as i32,
            z_averaging: report_feature_data.z_averaging as u32,
            z_dead_zone: report_feature_data.z_dead_zone as u32,
            rx_min: report_feature_data.rx_min as i32,
            rx_centr: report_feature_data._rx_centr as i32,
            rx_max: report_feature_data.rx_max as i32,
            rx_averaging: report_feature_data.rx_averaging as u32,
            rx_dead_zone: report_feature_data.rx_dead_zone as u32,
            ry_min: report_feature_data.ry_min as i32,
            ry_centr: report_feature_data._ry_centr as i32,
            ry_max: report_feature_data.ry_max as i32,
            ry_averaging: report_feature_data.ry_averaging as u32,
            ry_dead_zone: report_feature_data.ry_dead_zone as u32,
            rz_min: report_feature_data.rz_min as i32,
            rz_max: report_feature_data.rz_max as i32,
            rz_averaging: report_feature_data.rz_averaging as u32,
            rz_dead_zone: report_feature_data.rz_dead_zone as u32,
            slider_min: report_feature_data.slider_min as i32,
            slider_max: report_feature_data.slider_max as i32,
            slider_averaging: report_feature_data.slider_averaging as u32,
            slider_dead_zone: report_feature_data.slider_dead_zone as u32,
            encoder_time: report_feature_data.encoder_time as u32,
            led_r: report_feature_data.led_r as u32,
            led_g: report_feature_data.led_g as u32,
            led_b: report_feature_data.led_b as u32,
            id_grib: report_feature_data.id_grib as u32,
            hatka1_mode: report_feature_data.hatka1_mode as u32,
            hatka2_mode: report_feature_data.hatka2_mode as u32,
            hatka3_mode: report_feature_data.hatka3_mode as u32,
            hatka4_mode: report_feature_data.hatka4_mode as u32,
            control_byte: report_feature_data.control_byte as u32,
            gash_button1_min: report_feature_data.gash_button1_min as i32,
            gash_button1_max: report_feature_data.gash_button1_max as i32,
            gash_button2_min: report_feature_data.gash_button2_min as i32,
            gash_button2_max: report_feature_data.gash_button2_max as i32,
            gash_button3_min: report_feature_data.gash_button3_min as i32,
            gash_button3_max: report_feature_data.gash_button3_max as i32,
            spi_error_cnt: report_feature_data.spi_error_cnt as i32,
            fbuttons: report_feature_data.buttons as u64,
            x_axis: report_feature_data.x_axis as i32,
            y_axis: report_feature_data.y_axis as i32,
            z_axis: report_feature_data.z_axis as i32,
            rx_axis: report_feature_data.rx_axis as i32,
            ry_axis: report_feature_data.ry_axis as i32,
            rz_axis: report_feature_data.rz_axis as i32,
            slider_axis: report_feature_data.slider_axis as i32,
            fw_version: report_feature_data.fw_version as u32,
        };
        
        let rust_signal = RustSignal {
            resource: ID,
            message: Some(report_in_signal_message.encode_to_vec()),
            blob: None,
        };
        send_rust_signal(rust_signal);
    }
}

pub async fn handle_device(
    rust_request: RustRequest,
    adevice: Arc<Mutex<DeviceState>>,
) -> RustResponse {
    use crate::messages::device_info::{ReadResponse, ReadValues, SetValues};
    // We import message structs in this handler function
    // because schema will differ by Rust resource.

    match rust_request.operation {
        RustOperation::Create => RustResponse::default(),
        RustOperation::Update => {
            // Decode raw bytes into a Rust message object.
            let message_bytes = rust_request.message.unwrap();
            let set_message = SetValues::decode(message_bytes.as_slice()).unwrap();
            // crate::debug_print!("{}", request_message.letter);

            if set_message.target.as_str().starts_with("readconf") {
                let config_name = &set_message.target.as_str()[9..];
                // adevice.is_poisoned() // TODO: use together with error handling on disconnect
                adevice.lock().unwrap().read_from_file(config_name);
            };

            if set_message.target.as_str().starts_with("saveconf") {
                let config_name = &set_message.target.as_str()[9..];
                // adevice.is_poisoned() // TODO: use together with error handling on disconnect
                adevice.lock().unwrap().write_to_file(config_name);
            };

            let output_string = if set_message.target.as_str().starts_with("listconf") {
                // let config_name = &set_message.target.as_str()[9..];
                // adevice.is_poisoned() // TODO: use together with error handling on disconnect
                DeviceState::list_json_files().unwrap()
            } else {
                "none".to_owned()
            };

            let mm_res = match_message(adevice, set_message);

            let response_message = match mm_res {
                Ok(suc) => ReadResponse {
                    output_numbers: 200,
                    output_string: output_string,
                },
                Err(err) => ReadResponse {
                    output_numbers: 400,
                    output_string: err.to_owned(),
                }
            };
            

            // adevice.lock().unwrap().set_rgb_led(
            //     request_message.r.try_into().unwrap(), 
            //     request_message.g.try_into().unwrap(), 
            //     request_message.b.try_into().unwrap()
            // );
            
            // Return the response that will be sent to Dart.
            // let response_message = ReadResponse {
            //     output_numbers: 200,
            //     output_string: "success".to_owned(),
            // };
            RustResponse {
                successful: true,
                message: Some(response_message.encode_to_vec()),
                blob: None,
            }
        }
        RustOperation::Read => {
            let message_bytes = rust_request.message.unwrap();
            let read_message = SetValues::decode(message_bytes.as_slice()).unwrap();


            let response_message = ReadValues {
                target: todo!("add"),
                value1: todo!(),
                value2: todo!(),
                value3: todo!(),
                value4: todo!(),
            };
            RustResponse {
                successful: true,
                message: Some(response_message.encode_to_vec()),
                blob: None,
            }
        },
        RustOperation::Delete => RustResponse::default(),
    }
}

pub fn match_message(adevice: Arc<Mutex<DeviceState>>, set_message: SetValues) -> Result<(), &'static str> {

    match set_message.target.as_str() {
        "apply" => adevice.lock().unwrap().send_feature(),
        "setx" => adevice.lock().unwrap().set_x(
            set_message.value1.try_into().unwrap(),
            set_message.value2.try_into().unwrap(),
            set_message.value3.try_into().unwrap(),
            set_message.value4.try_into().unwrap(),
        ),
        "sety" => adevice.lock().unwrap().set_y(
            set_message.value1.try_into().unwrap(),
            set_message.value2.try_into().unwrap(),
            set_message.value3.try_into().unwrap(),
            set_message.value4.try_into().unwrap(),
        ),
        "setz" => adevice.lock().unwrap().set_z(
            set_message.value1.try_into().unwrap(),
            set_message.value2.try_into().unwrap(),
            set_message.value3.try_into().unwrap(),
            set_message.value4.try_into().unwrap(),
        ),
        "setrx" => adevice.lock().unwrap().set_rx(
            set_message.value1.try_into().unwrap(),
            set_message.value2.try_into().unwrap(),
            set_message.value3.try_into().unwrap(),
            set_message.value4.try_into().unwrap(),
        ),
        "setry" => adevice.lock().unwrap().set_ry(
            set_message.value1.try_into().unwrap(),
            set_message.value2.try_into().unwrap(),
            set_message.value3.try_into().unwrap(),
            set_message.value4.try_into().unwrap(),
        ),
        "setrz" => adevice.lock().unwrap().set_rz(
            set_message.value1.try_into().unwrap(),
            set_message.value2.try_into().unwrap(),
            set_message.value3.try_into().unwrap(),
            set_message.value4.try_into().unwrap(),
        ),
        "setslider" => adevice.lock().unwrap().set_slider(
            set_message.value1.try_into().unwrap(),
            set_message.value2.try_into().unwrap(),
            set_message.value3.try_into().unwrap(),
            set_message.value4.try_into().unwrap(),
        ),
        "setencoder" => adevice.lock().unwrap().set_encoder(
            set_message.value1.try_into().unwrap(),
        ),
        "setled" => adevice.lock().unwrap().set_rgb_led(
            set_message.value1.try_into().unwrap(),
            set_message.value2.try_into().unwrap(),
            set_message.value3.try_into().unwrap(),
        ),
        "sethatka1" => adevice.lock().unwrap().set_hatka1_mode(
            set_message.value1.try_into().unwrap(),
        ),
        "sethatka2" => adevice.lock().unwrap().set_hatka2_mode(
            set_message.value1.try_into().unwrap(),
        ),
        "sethatka3" => adevice.lock().unwrap().set_hatka3_mode(
            set_message.value1.try_into().unwrap(),
        ),
        "sethatka4" => adevice.lock().unwrap().set_hatka4_mode(
            set_message.value1.try_into().unwrap(),
        ),
        "setgash1" => adevice.lock().unwrap().set_gash1(
            set_message.value1.try_into().unwrap(),
            set_message.value2.try_into().unwrap(),
        ),
        "setgash2" => adevice.lock().unwrap().set_gash2(
            set_message.value1.try_into().unwrap(),
            set_message.value2.try_into().unwrap(),
        ),
        "setgash3" => adevice.lock().unwrap().set_gash3(
            set_message.value1.try_into().unwrap(),
            set_message.value2.try_into().unwrap(),
        ),
        "togglelr" => adevice.lock().unwrap().set_toggle_lr(),
        "enabledfu" => adevice.lock().unwrap().set_enable_dfu(),
        "calibratehandle" => adevice.lock().unwrap().set_enable_calibrate_base(),
        "calibratebase" => adevice.lock().unwrap().set_enable_calibrate_handle(),
        "discalibratehandle" => adevice.lock().unwrap().set_disable_calibrate_base(),
        "discalibratebase" => adevice.lock().unwrap().set_disable_calibrate_handle(),
        "save" => adevice.lock().unwrap().set_save_config(),
        _ => println!("CONFIG FUNCTION happened"),
    }

    Ok(())
}