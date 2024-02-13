#![allow(unused_imports)]
#![allow(unused_mut)]

use prost::Message;
use rinf::DartSignal;
use std::cell::RefCell;
use std::collections::HashMap;
use std::sync::Mutex;
use std::sync::OnceLock;

type SignalHandlers =
    OnceLock<Mutex<HashMap<i32, Box<dyn Fn(Vec<u8>, Option<Vec<u8>>) + Send>>>>;
static SIGNAL_HANDLERS: SignalHandlers = OnceLock::new();

pub fn handle_dart_signal(
    message_id: i32,
    message_bytes: Vec<u8>,
    blob: Option<Vec<u8>>
) {    
    let mutex = SIGNAL_HANDLERS.get_or_init(|| {
        let mut hash_map =
            HashMap
            ::<i32, Box<dyn Fn(Vec<u8>, Option<Vec<u8>>) + Send + 'static>>
            ::new();
        Mutex::new(hash_map)
    });

    let guard = mutex.lock().unwrap();
    let signal_handler = guard.get(&message_id).unwrap();
    signal_handler(message_bytes, blob);
}
