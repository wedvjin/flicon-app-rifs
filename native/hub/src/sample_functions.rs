//! This module is only for demonstration purposes.
//! You might want to remove this module in production.

use std::sync::{Arc, Mutex};

use crate::bridge::api::{RustOperation, RustRequest, RustResponse, RustSignal};
use crate::bridge::send_rust_signal;
use prost::Message;
use sample_crate::DeviceState;

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

pub async fn handle_counter_number(rust_request: RustRequest) -> RustResponse {
    use crate::messages::counter_number::{ReadRequest, ReadResponse};
    // We import message structs in this handler function
    // because schema will differ by Rust resource.

    match rust_request.operation {
        RustOperation::Create => RustResponse::default(),
        RustOperation::Read => {
            // Decode raw bytes into a Rust message object.
            let message_bytes = rust_request.message.unwrap();
            let request_message = ReadRequest::decode(message_bytes.as_slice()).unwrap();
            crate::debug_print!("{}", request_message.letter);

            // Perform a simple calculation.
            let after_value: i32 = sample_crate::add_seven(request_message.before_number);

            // Return the response that will be sent to Dart.
            let response_message = ReadResponse {
                after_number: after_value,
                dummy_one: request_message.dummy_one,
                dummy_two: request_message.dummy_two,
                dummy_three: request_message.dummy_three,
            };
            RustResponse {
                successful: true,
                message: Some(response_message.encode_to_vec()),
                blob: None,
            }
        }
        RustOperation::Update => RustResponse::default(),
        RustOperation::Delete => RustResponse::default(),
    }
}

pub async fn stream_mandelbrot() {
    use crate::messages::mandelbrot::{StateSignal, ID};

    let mut scale: f64 = 1.0;

    let (frame_sender, mut frame_receiver) = tokio::sync::mpsc::channel(25);

    // Send frames in order.
    crate::spawn(async move {
        loop {
            // Wait for 40 milliseconds on each frame
            crate::sleep(std::time::Duration::from_millis(40)).await;
            if frame_sender.capacity() == 0 {
                continue;
            }

            scale *= 0.98;
            if scale < 1e-7 {
                scale = 1.0
            };

            // Calculate the mandelbrot image
            // parallelly in a separate thread pool.
            let join_handle = crate::spawn_blocking(move || {
                sample_crate::mandelbrot(
                    sample_crate::Size {
                        width: 384,
                        height: 384,
                    },
                    sample_crate::Point {
                        x: 0.360,
                        y: -0.641,
                    },
                    scale,
                    4,
                )
            });
            let _ = frame_sender.send(join_handle).await;
        }
    });

    // Receive frames in order.
    crate::spawn(async move {
        loop {
            let join_handle = frame_receiver.recv().await.unwrap();
            let received_frame = join_handle.await.unwrap();
            if let Some(mandelbrot) = received_frame {
                // Stream the signal to Dart.
                let signal_message = StateSignal {
                    id: 0,
                    current_scale: scale,
                };
                let rust_signal = RustSignal {
                    resource: ID,
                    message: Some(signal_message.encode_to_vec()),
                    blob: Some(mandelbrot),
                };
                send_rust_signal(rust_signal);
            };
        }
    });
}

#[allow(unreachable_code)]
pub async fn run_debug_tests() {
    #[cfg(not(debug_assertions))]
    return;

    crate::sleep(std::time::Duration::from_secs(1)).await;
    crate::debug_print!("Starting debug tests.");

    // Get the current time.
    let current_time = sample_crate::get_current_time();
    crate::debug_print!("System time: {}", current_time);

    // Use a crate that accesses operating system APIs.
    let option = sample_crate::get_hardward_id();
    if let Some(hwid) = option {
        crate::debug_print!("Hardware ID: {}", hwid);
    } else {
        crate::debug_print!("Hardware ID is not available on this platform.");
    }

    // Test `tokio::join!` for futures.
    let join_first = async {
        crate::sleep(std::time::Duration::from_secs(1)).await;
        crate::debug_print!("First future finished.");
    };
    let join_second = async {
        crate::sleep(std::time::Duration::from_secs(2)).await;
        crate::debug_print!("Second future finished.");
    };
    let join_third = async {
        crate::sleep(std::time::Duration::from_secs(3)).await;
        crate::debug_print!("Third future finished.");
    };
    tokio::join!(join_first, join_second, join_third);

    // Avoid blocking the async event loop by yielding.
    let mut last_time = sample_crate::get_current_time();
    let mut count = 0u64;
    let mut steps_finished = 0;
    loop {
        count += 1;
        if count % 10000 == 0 {
            crate::yield_now().await;
            let time_passed = sample_crate::get_current_time() - last_time;
            if time_passed.num_milliseconds() > 1000 {
                crate::debug_print!("Counted to {count}, yielding regularly.");
                last_time = sample_crate::get_current_time();
                steps_finished += 1;
                if steps_finished == 10 {
                    break;
                }
            }
        }
    }

    // Test `spawn_blocking` with multicore parallelization.
    let mut join_handles = Vec::new();
    let chunk_size = 10_i32.pow(6);
    for level in 0..10 {
        let join_handle = crate::spawn_blocking(move || {
            let mut prime_count = 0;
            let count_from = level * chunk_size + 1;
            let count_to = (level + 1) * chunk_size;
            for number in count_from..=count_to {
                let mut is_prime = true;
                let square_root = (number as f64).sqrt() as i32;
                if number <= 1 {
                    is_prime = false;
                } else {
                    let mut i = 2;
                    while i <= square_root {
                        if number % i == 0 {
                            is_prime = false;
                            break;
                        }
                        i += 1;
                    }
                }
                if is_prime {
                    prime_count += 1;
                }
            }
            format!("There are {prime_count} primes from {count_from} to {count_to}.")
        });
        join_handles.push(join_handle);
    }
    for join_handle in join_handles {
        let text = join_handle.await.unwrap();
        crate::debug_print!("{text}");
    }

    crate::debug_print!("Debug tests completed!");
    panic!("INTENTIONAL DEBUG PANIC");
}

pub async fn stream_increasing_number() {
    use crate::messages::increasing_number::{StateSignal, ID};

    let mut current_number: i32 = 1;
    loop {
        crate::sleep(std::time::Duration::from_secs(1)).await;

        let signal_message = StateSignal { current_number };
        let rust_signal = RustSignal {
            resource: ID,
            message: Some(signal_message.encode_to_vec()),
            blob: None,
        };
        send_rust_signal(rust_signal);

        current_number += 1;
    }
}

pub async fn stream_report_in(
    device: Arc<Mutex<DeviceState>>,
) {
    use crate::messages::report_in_message::{ReportInMessage, ID};

    // let device = sample_crate::DeviceState::new();
    
    // let mut counter = 0;
    loop {
        crate::sleep(std::time::Duration::from_millis(40)).await;
        let report_in_data = device.lock().unwrap().get_data();
        
        let report_in_signal_message = ReportInMessage {
            id: report_in_data.id as u32,
            buttons: report_in_data.buttons as u64,
            x: report_in_data.x_axis as u32,
            y: report_in_data.y_axis as u32,
            z: report_in_data.z_axis as u32,
            rx: report_in_data.rx_axis as u32,
            ry: report_in_data.ry_axis as u32,
            rz: report_in_data.rz_axis as u32,
            slider: report_in_data.slider_axis as u32,
        };
        let rust_signal = RustSignal {
            resource: ID,
            message: Some(report_in_signal_message.encode_to_vec()),
            blob: None,
        };

        send_rust_signal(rust_signal);
        // counter += 1;
        
    }

    // let (report_in_tx, mut report_in_rx) = tokio::sync::mpsc::channel(25);

    // let mut current_number: i32 = 1;

    // crate::spawn(async move {
    //     let device = sample_crate::DeviceState::new();
    //     loop {
    //         // Wait for 40 milliseconds on each frame
    //         crate::sleep(std::time::Duration::from_millis(40)).await;
    //         if report_in_tx.capacity() == 0 {
    //             continue;
    //         }

    //         // Calculate the mandelbrot image
    //         // parallelly in a separate thread pool.
    //         // let join_handle = crate::spawn_blocking(move || {
    //         //     // sample_crate::mandelbrot(
    //         //     //     sample_crate::Size {
    //         //     //         width: 384,
    //         //     //         height: 384,
    //         //     //     },
    //         //     //     sample_crate::Point {
    //         //     //         x: 0.360,
    //         //     //         y: -0.641,
    //         //     //     },
    //         //     //     scale,
    //         //     //     4,
    //         //     // )
    //         //     device.get_data()
    //         // });
    //         let data = device.get_data();
    //         let _ = report_in_tx.send(data).await;
    //     }
    // });

    // // Receive frames in order.
    // crate::spawn(async move {
    //     loop {
    //         let received_report_in = report_in_rx.recv().await.unwrap();
    //         let signal_message = StateSignal {
    //             current_number: 0
    //         };
    //         let rust_signal = RustSignal {
    //             resource: ID,
    //             message: Some(signal_message.encode_to_vec()),
    //             blob: Some(received_report_in.to_vec()),
    //         };
    //         send_rust_signal(rust_signal);
    //         // if let Some(mandelbrot) = received_frame {
    //         //     // Stream the signal to Dart.
    //         //     let signal_message = StateSignal {
    //         //         id: 0,
    //         //         current_scale: scale,
    //         //     };
    //         //     let rust_signal = RustSignal {
    //         //         resource: ID,
    //         //         message: Some(signal_message.encode_to_vec()),
    //         //         blob: Some(mandelbrot),
    //         //     };
    //         //     send_rust_signal(rust_signal);
    //         // };
    //     }
    // });



    // loop {
    //     crate::sleep(std::time::Duration::from_secs(1)).await;

    //     let signal_message = StateSignal { current_number };
    //     let rust_signal = RustSignal {
    //         resource: ID,
    //         message: Some(signal_message.encode_to_vec()),
    //         blob: None,
    //     };
    //     send_rust_signal(rust_signal);

    //     current_number += 1;
    // }
}

pub async fn stream_report_feature(
    device: Arc<Mutex<DeviceState>>,
) {
    use crate::messages::report_feature_message::{ReportFeature, ID};

    loop {

        crate::sleep(std::time::Duration::from_millis(40)).await;
        let report_feature_data = device.lock().unwrap().get_report();

        let report_feature_signal_message = ReportFeature {
            id: report_feature_data.id as u32,
            x_min: report_feature_data.x_min as u32,
            x_centr: report_feature_data._x_centr as u32,
            x_max: report_feature_data.x_max as u32,
            x_averaging: report_feature_data.x_averaging as u32,
            x_dead_zone: report_feature_data.x_dead_zone as u32,
            y_min: report_feature_data.y_min as u32,
            y_centr: report_feature_data._y_centr as u32,
            y_max: report_feature_data.y_max as u32,
            y_averaging: report_feature_data.y_averaging as u32,
            y_dead_zone: report_feature_data.y_dead_zone as u32,
            z_min: report_feature_data.z_min as u32,
            z_centr: report_feature_data._z_centr as u32,
            z_max: report_feature_data.z_max as u32,
            z_averaging: report_feature_data.z_averaging as u32,
            z_dead_zone: report_feature_data.z_dead_zone as u32,
            rx_min: report_feature_data.rx_min as u32,
            rx_centr: report_feature_data._rx_centr as u32,
            rx_max: report_feature_data.rx_max as u32,
            rx_averaging: report_feature_data.rx_averaging as u32,
            rx_dead_zone: report_feature_data.rx_dead_zone as u32,
            ry_min: report_feature_data.ry_min as u32,
            ry_centr: report_feature_data._ry_centr as u32,
            ry_max: report_feature_data.ry_max as u32,
            ry_averaging: report_feature_data.ry_averaging as u32,
            ry_dead_zone: report_feature_data.ry_dead_zone as u32,
            rz_min: report_feature_data.rz_min as u32,
            rz_centr: report_feature_data._rz_centr as u32,
            rz_max: report_feature_data.rz_max as u32,
            rz_averaging: report_feature_data.rz_averaging as u32,
            rz_dead_zone: report_feature_data.rz_dead_zone as u32,
            slider_min: report_feature_data.slider_min as u32,
            slider_max: report_feature_data.slider_max as u32,
            slider_averaging: report_feature_data.slider_averaging as u32,
            slider_dead_zone: report_feature_data.slider_dead_zone as u32,
            encoder_time: report_feature_data.encoder_time as u32,
            led_r: report_feature_data.led_r as u32,
            led_g: report_feature_data.led_g as u32,
            led_b: report_feature_data.led_b as u32,
            hatka1_mode: report_feature_data.hatka1_mode as u32,
            hatka2_mode: report_feature_data.hatka2_mode as u32,
            hatka3_mode: report_feature_data.hatka3_mode as u32,
            hatka4_mode: report_feature_data.hatka4_mode as u32,
            control_byte: report_feature_data.control_byte as u32,
            gash_button1_min: report_feature_data.gash_button1_min as u32,
            gash_button1_max: report_feature_data.gash_button1_max as u32,
            gash_button2_min: report_feature_data.gash_button2_min as u32,
            gash_button2_max: report_feature_data.gash_button2_max as u32,
            gash_button3_min: report_feature_data.gash_button3_min as u32,
            gash_button3_max: report_feature_data.gash_button3_max as u32,
            spi_error_cnt: report_feature_data.spi_error_cnt as u32,
            buttons: report_feature_data.buttons as u64,
            x_axis: report_feature_data.x_axis as u32,
            y_axis: report_feature_data.y_axis as u32,
            z_axis: report_feature_data.z_axis as u32,
            rx_axis: report_feature_data.rx_axis as u32,
            ry_axis: report_feature_data.ry_axis as u32,
            rz_axis: report_feature_data.rz_axis as u32,
            slider_axis: report_feature_data.slider_axis as u32,
            fw_version: report_feature_data.fw_version as u32,
        };

        let rust_signal = RustSignal {
            resource: ID,
            message: Some(report_feature_signal_message.encode_to_vec()),
            blob: None,
        };

        send_rust_signal(rust_signal);
    }
}

// pub async fn handle_device_info(rust_request: RustRequest) -> RustResponse {
//     use crate::messages::device_info::{ReadRequest, ReadResponse};

//     match rust_request.operation {
//         RustOperation::Create => RustResponse::default(),
//         RustOperation::Read => {
//             let message_bytes = rust_request.message.unwrap();
//             let request_message = ReadRequest::decode(message_bytes.as_slice()).unwrap();

//             // let new_numbers: Vec<i32> = request_message
//             //     .input_numbers
//             //     .into_iter()
//             //     .map(|x| x + 1)
//             //     .collect();
//             // let new_string = request_message.input_string.to_uppercase();

//             let mut device = sample_crate::DeviceState::new();
//             let left_or_right = device.get_side();

//             let new_string = match left_or_right {
//                 true => "right".to_string(),
//                 false => "left".to_string(),
//             };

//             // let new_string =String::from_utf8(device.get_data().to_vec()).unwrap();
//             let new_numbers = 0;
//             let response_message = ReadResponse {
//                 output_numbers: new_numbers,
//                 output_string: new_string,
//             };
//             RustResponse {
//                 successful: true,
//                 message: Some(response_message.encode_to_vec()),
//                 blob: None,
//             }
//         }
//         RustOperation::Update => RustResponse::default(),
//         RustOperation::Delete => RustResponse::default(),
//     }
// }

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
                "save" => adevice.lock().unwrap().set_save_config(),
                _ => println!("INCORRECT OPTION PASSED or NOT IMPLEMENTED"),
            }
            

            // adevice.lock().unwrap().set_rgb_led(
            //     request_message.r.try_into().unwrap(), 
            //     request_message.g.try_into().unwrap(), 
            //     request_message.b.try_into().unwrap()
            // );
            
            // Return the response that will be sent to Dart.
            let response_message = ReadResponse {
                output_numbers: 200,
                output_string: "success".to_owned(),
            };
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