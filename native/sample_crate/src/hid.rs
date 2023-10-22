extern crate hidapi;
use std::{path::PathBuf, fs::{OpenOptions, File, self}, io::{Write, Read}};

use anyhow::{anyhow, Result};
use hidapi::{DeviceInfo, HidDevice};

use byteorder::{LittleEndian, WriteBytesExt};
use serde::{de::value, Serialize, Deserialize};

const VENDOR_ID_CONST: u16 = 13911;
const BASE_PATH: &str = "C:\\Users\\YourUsername\\Documents\\Flicon\\";

pub struct DeviceState {
    pub connected: bool,
    pub device: Option<Box<HidDevice>>,
    pub controller_info: Option<DeviceInfo>,
    pub feature: Option<ReportFeature>,
}

impl DeviceState {
    pub fn new() -> Self {
        let api = hidapi::HidApi::new().unwrap();
 
        let device_info_res = api
            .device_list()
            .into_iter()
            .find(|&device| device.vendor_id() == VENDOR_ID_CONST);

        if let Some(device_info) = device_info_res {
            let device = api.open(device_info.vendor_id(), device_info.product_id()).unwrap();
            let feature_report = get_report(&device);
            let boxed_device = Box::new(device);
            return DeviceState { connected: true, device: Some(boxed_device), controller_info: Some(device_info.clone()), feature: Some(feature_report.unwrap())};
            
        } else {

            // let feautre_report = ReportFeature {
            //     ..Default::default()
            // };
            return DeviceState { connected: false, device: None, controller_info: None, feature: None};
        }
                
    }

    pub fn reinst(&mut self) {
        let api = hidapi::HidApi::new().unwrap();
 
        let device_info_res = api
            .device_list()
            .into_iter()
            .find(|&device| device.vendor_id() == VENDOR_ID_CONST);

        if let Some(device_info) = device_info_res {
            let device = api.open(device_info.vendor_id(), device_info.product_id()).unwrap();
            self.feature = Some(get_report(&device).unwrap());
            self.device = Some(Box::new(device));
            self.controller_info = Some(device_info.clone());
            self.connected = true;

            // return DeviceState { connected: true, device: Some(boxed_device), controller_info: Some(device_info.clone()), feature: Some(feature_report.unwrap())};
            
        } else {

            // let feautre_report = ReportFeature {
            //     ..Default::default()
            // };
            self.connected = false;
            self.device = None;
            self.controller_info = None;
            self.feature = Some(ReportFeature {
                ..Default::default()
            });
            // return DeviceState { connected: false, device: None, controller_info: None, feature: None};
        }
    }

    // SHALL BE CALLED TO SET THE REPORT WORKAROUND FOR NOW
    // pub fn set_report_internal(&mut self) {
    //     self.feature = Some(self.get_report());
    // }

    // pub fn get_feature_report(&self) {
    //     let feature_report = get_feature_report(&self.device).unwrap();
    //     println!("feature report: {:?}", feature_report);

    // }

    pub fn get_feature_report_bytes(&self) {
        let mut buf: [u8; 129] = [0; 129];
        // buf[0] = 5;
        // let mut buf: Vec<u8> = Vec::new();
        // for _vl in 0..buffer_length {
        //     buf.push(0);
        // }
        // let mut buf: [u8; 128] = [0; 128];
        // let res = self.device.get_report_descriptor(&mut buf);
        
        buf[0] = 2;
        let res = self.device.as_ref().unwrap().get_feature_report(&mut buf).unwrap();
        //  {
        //     Ok(res) => {
        //         for byte in buf.iter() {
        //             print!("{:08b} ", byte); // This will print each byte in hexadecimal format
        //         }
        //         println!("Good buffer length: {}", buffer_length);
        //         res
        //     }
        //     Err(e) => {
        //         // println!("error {:?} on buffer length {}", e, buffer_length);
        //         0
        //     }
        // };
        // let res = self.device.get_feature_report(&mut buf);  //TODO uncomment and see if it returns but with error
        // println!("res: {:?}", res);
        for byte in buf.iter() {
            print!("{:08b} ", byte); // This will print each byte in hexadecimal format
        }

    }

    pub fn get_device_name(&self) {
        println!("{:?}", self.device.as_ref().unwrap().get_manufacturer_string());
        println!("{:?}", self.device.as_ref().unwrap().get_product_string());
        println!("{:?}", self.device.as_ref().unwrap().get_serial_number_string());
    }

    pub fn get_data(
        &self
    ) -> Result<
        ReportIn
    > {
        let mut buf = [0u8; 21];
        let dd_res = self.device.as_ref();
        let dd = match dd_res{
            Some(dd) => dd,
            None => return Err(anyhow!("DISCONNECTED"))
        };
        let res = dd.read(&mut buf[..]).unwrap_or_default();
        if res == 0 {
            return Err(anyhow!("DISCONNECTED"));
        }
        // println!("res data {}", res);
        let report_in = ReportIn {
                id: buf[0],
                buttons: to_u64_from_6_bytes(buf[1..7].try_into().unwrap()),
                x_axis: u16::from_le_bytes(buf[7..9].try_into().unwrap()),
                y_axis: u16::from_le_bytes(buf[9..11].try_into().unwrap()),
                z_axis: u16::from_le_bytes(buf[11..13].try_into().unwrap()),
                rx_axis: u16::from_le_bytes(buf[13..15].try_into().unwrap()),
                ry_axis: u16::from_le_bytes(buf[15..17].try_into().unwrap()),
                rz_axis: u16::from_le_bytes(buf[17..19].try_into().unwrap()),
                slider_axis: u16::from_le_bytes(buf[19..21].try_into().unwrap()),
            };
        Ok(report_in)
    }
    // pub fn get_data(&self) -> ReportIn {
    //     get_data(&self.device.as_ref().unwrap()).unwrap()
    // }

    // pub fn get_report(&self) -> ReportFeature {
    //     get_report(&self.device.as_ref().unwrap()).unwrap()
    // }

    pub fn get_report(
        &self
    ) -> Result<ReportFeature> {
        // let api = hidapi::HidApi::new().unwrap();
    
        // let controller = get_controller().unwrap();
        // let device = api.open(controller.vendor_id(), controller.product_id()).unwrap();
    
        let mut buf: [u8; 129] = [0; 129];
        buf[0] = 2;
        let dd_res = self.device.as_ref();
        let dd = match dd_res{
            Some(dd) => dd,
            None => return Err(anyhow!("DISCONNECTED"))
        };
        let res = dd.get_feature_report(&mut buf).unwrap_or_default();
        if res == 0 {
            return Err(anyhow!("DISCONNECTED"));
        }
        // println!("res: {}", res);
        // let res = device.get_feature_report(&mut buf).unwrap();
    
        let report_feature = ReportFeature {
            id: buf[0],
            x_min: i16::from_le_bytes(buf[1..3].try_into().unwrap()),
            _x_centr: i16::from_le_bytes(buf[3..5].try_into().unwrap()),
            x_max: i16::from_le_bytes(buf[5..7].try_into().unwrap()),
            x_averaging: u8::from_le_bytes(buf[7..8].try_into().unwrap()),
            x_dead_zone: u8::from_le_bytes(buf[8..9].try_into().unwrap()),
            y_min: i16::from_le_bytes(buf[9..11].try_into().unwrap()),
            _y_centr: i16::from_le_bytes(buf[11..13].try_into().unwrap()),
            y_max: i16::from_le_bytes(buf[13..15].try_into().unwrap()),
            y_averaging: u8::from_le_bytes(buf[15..16].try_into().unwrap()),
            y_dead_zone: u8::from_le_bytes(buf[16..17].try_into().unwrap()),
            z_min: i16::from_le_bytes(buf[17..19].try_into().unwrap()),
            _z_centr: i16::from_le_bytes(buf[19..21].try_into().unwrap()),
            z_max: i16::from_le_bytes(buf[21..23].try_into().unwrap()),
            z_averaging: u8::from_le_bytes(buf[23..24].try_into().unwrap()),
            z_dead_zone: u8::from_le_bytes(buf[24..25].try_into().unwrap()),
            rx_min: i16::from_le_bytes(buf[25..27].try_into().unwrap()),
            _rx_centr: i16::from_le_bytes(buf[27..29].try_into().unwrap()),
            rx_max: i16::from_le_bytes(buf[29..31].try_into().unwrap()),
            rx_averaging: u8::from_le_bytes(buf[31..32].try_into().unwrap()),
            rx_dead_zone: u8::from_le_bytes(buf[32..33].try_into().unwrap()),
            ry_min: i16::from_le_bytes(buf[33..35].try_into().unwrap()),
            _ry_centr: i16::from_le_bytes(buf[35..37].try_into().unwrap()),
            ry_max: i16::from_le_bytes(buf[37..39].try_into().unwrap()),
            ry_averaging: u8::from_le_bytes(buf[39..40].try_into().unwrap()),
            ry_dead_zone: u8::from_le_bytes(buf[40..41].try_into().unwrap()),
            rz_min: i16::from_le_bytes(buf[41..43].try_into().unwrap()),
            rz_max: i16::from_le_bytes(buf[43..45].try_into().unwrap()),
            rz_averaging: u8::from_le_bytes(buf[45..46].try_into().unwrap()),
            rz_dead_zone: u8::from_le_bytes(buf[46..47].try_into().unwrap()),
            slider_min: i16::from_le_bytes(buf[47..49].try_into().unwrap()),
            slider_max: i16::from_le_bytes(buf[49..51].try_into().unwrap()),
            slider_averaging: u8::from_le_bytes(buf[51..52].try_into().unwrap()),
            slider_dead_zone: u8::from_le_bytes(buf[52..53].try_into().unwrap()),
            encoder_time: u8::from_le_bytes(buf[53..54].try_into().unwrap()),
            led_r: u8::from_le_bytes(buf[54..55].try_into().unwrap()),
            led_g: u8::from_le_bytes(buf[55..56].try_into().unwrap()),
            led_b: u8::from_le_bytes(buf[56..57].try_into().unwrap()),
            id_grib: u8::from_le_bytes(buf[57..58].try_into().unwrap()),
            hatka1_mode: u8::from_le_bytes(buf[58..59].try_into().unwrap()),
            hatka2_mode: u8::from_le_bytes(buf[59..60].try_into().unwrap()),
            hatka3_mode: u8::from_le_bytes(buf[60..61].try_into().unwrap()),
            hatka4_mode: u8::from_le_bytes(buf[61..62].try_into().unwrap()),
            control_byte: u8::from_le_bytes(buf[62..63].try_into().unwrap()),
            gash_button1_min: i16::from_le_bytes(buf[63..65].try_into().unwrap()),
            gash_button1_max: i16::from_le_bytes(buf[65..67].try_into().unwrap()),
            gash_button2_min: i16::from_le_bytes(buf[67..69].try_into().unwrap()),
            gash_button2_max: i16::from_le_bytes(buf[69..71].try_into().unwrap()),
            gash_button3_min: i16::from_le_bytes(buf[71..73].try_into().unwrap()),
            gash_button3_max: i16::from_le_bytes(buf[73..75].try_into().unwrap()),
            spi_error_cnt: u8::from_le_bytes(buf[75..76].try_into().unwrap()),
            buttons: to_u64_from_6_bytes(buf[76..82].try_into().unwrap()),
            x_axis: i16::from_le_bytes(buf[82..84].try_into().unwrap()),
            y_axis: i16::from_le_bytes(buf[84..86].try_into().unwrap()),
            z_axis: i16::from_le_bytes(buf[86..88].try_into().unwrap()),
            rx_axis: i16::from_le_bytes(buf[88..90].try_into().unwrap()),
            ry_axis: i16::from_le_bytes(buf[90..92].try_into().unwrap()),
            rz_axis: i16::from_le_bytes(buf[92..94].try_into().unwrap()),
            slider_axis: i16::from_le_bytes(buf[94..96].try_into().unwrap()),
            fw_version: u16::from_le_bytes(buf[96..98].try_into().unwrap()),
        };
    
        // println!("Read: {:?}", &buf[..res]);
        // println!("Feature report: {:?}",report_feature);
        Ok(report_feature)
    }

    pub fn get_report_descriptor(&self) -> ReportFeature {
        let mut buf: [u8; 4096] = [0; 4096]; //TODO:
        buf[0] = 2;
        let res = (&self.device).as_ref().unwrap().get_report_descriptor(&mut buf).unwrap();
        // let res = device.get_feature_report(&mut buf).unwrap();

        // let buf = &buf_resreq[44..];

        let report_feature = ReportFeature {
            id: buf[0],
            x_min: i16::from_le_bytes(buf[1..3].try_into().unwrap()),
            _x_centr: i16::from_le_bytes(buf[3..5].try_into().unwrap()),
            x_max: i16::from_le_bytes(buf[5..7].try_into().unwrap()),
            x_averaging: u8::from_le_bytes(buf[7..8].try_into().unwrap()),
            x_dead_zone: u8::from_le_bytes(buf[8..9].try_into().unwrap()),
            y_min: i16::from_le_bytes(buf[9..11].try_into().unwrap()),
            _y_centr: i16::from_le_bytes(buf[11..13].try_into().unwrap()),
            y_max: i16::from_le_bytes(buf[13..15].try_into().unwrap()),
            y_averaging: u8::from_le_bytes(buf[15..16].try_into().unwrap()),
            y_dead_zone: u8::from_le_bytes(buf[16..17].try_into().unwrap()),
            z_min: i16::from_le_bytes(buf[17..19].try_into().unwrap()),
            _z_centr: i16::from_le_bytes(buf[19..21].try_into().unwrap()),
            z_max: i16::from_le_bytes(buf[21..23].try_into().unwrap()),
            z_averaging: u8::from_le_bytes(buf[23..24].try_into().unwrap()),
            z_dead_zone: u8::from_le_bytes(buf[24..25].try_into().unwrap()),
            rx_min: i16::from_le_bytes(buf[25..27].try_into().unwrap()),
            _rx_centr: i16::from_le_bytes(buf[27..29].try_into().unwrap()),
            rx_max: i16::from_le_bytes(buf[29..31].try_into().unwrap()),
            rx_averaging: u8::from_le_bytes(buf[31..32].try_into().unwrap()),
            rx_dead_zone: u8::from_le_bytes(buf[32..33].try_into().unwrap()),
            ry_min: i16::from_le_bytes(buf[33..35].try_into().unwrap()),
            _ry_centr: i16::from_le_bytes(buf[35..37].try_into().unwrap()),
            ry_max: i16::from_le_bytes(buf[37..39].try_into().unwrap()),
            ry_averaging: u8::from_le_bytes(buf[39..40].try_into().unwrap()),
            ry_dead_zone: u8::from_le_bytes(buf[40..41].try_into().unwrap()),
            rz_min: i16::from_le_bytes(buf[41..43].try_into().unwrap()),
            rz_max: i16::from_le_bytes(buf[43..45].try_into().unwrap()),
            rz_averaging: u8::from_le_bytes(buf[45..46].try_into().unwrap()),
            rz_dead_zone: u8::from_le_bytes(buf[46..47].try_into().unwrap()),
            slider_min: i16::from_le_bytes(buf[47..49].try_into().unwrap()),
            slider_max: i16::from_le_bytes(buf[49..51].try_into().unwrap()),
            slider_averaging: u8::from_le_bytes(buf[51..52].try_into().unwrap()),
            slider_dead_zone: u8::from_le_bytes(buf[52..53].try_into().unwrap()),
            encoder_time: u8::from_le_bytes(buf[53..54].try_into().unwrap()),
            led_r: u8::from_le_bytes(buf[54..55].try_into().unwrap()),
            led_g: u8::from_le_bytes(buf[55..56].try_into().unwrap()),
            led_b: u8::from_le_bytes(buf[56..57].try_into().unwrap()),
            id_grib: u8::from_le_bytes(buf[57..58].try_into().unwrap()),
            hatka1_mode: u8::from_le_bytes(buf[58..59].try_into().unwrap()),
            hatka2_mode: u8::from_le_bytes(buf[59..60].try_into().unwrap()),
            hatka3_mode: u8::from_le_bytes(buf[60..61].try_into().unwrap()),
            hatka4_mode: u8::from_le_bytes(buf[61..62].try_into().unwrap()),
            control_byte: u8::from_le_bytes(buf[62..63].try_into().unwrap()),
            gash_button1_min: i16::from_le_bytes(buf[63..65].try_into().unwrap()),
            gash_button1_max: i16::from_le_bytes(buf[65..67].try_into().unwrap()),
            gash_button2_min: i16::from_le_bytes(buf[67..69].try_into().unwrap()),
            gash_button2_max: i16::from_le_bytes(buf[69..71].try_into().unwrap()),
            gash_button3_min: i16::from_le_bytes(buf[71..73].try_into().unwrap()),
            gash_button3_max: i16::from_le_bytes(buf[73..75].try_into().unwrap()),
            spi_error_cnt: u8::from_le_bytes(buf[75..76].try_into().unwrap()),
            buttons: to_u64_from_6_bytes(buf[76..82].try_into().unwrap()),
            x_axis: i16::from_le_bytes(buf[82..84].try_into().unwrap()),
            y_axis: i16::from_le_bytes(buf[84..86].try_into().unwrap()),
            z_axis: i16::from_le_bytes(buf[86..88].try_into().unwrap()),
            rx_axis: i16::from_le_bytes(buf[88..90].try_into().unwrap()),
            ry_axis: i16::from_le_bytes(buf[90..92].try_into().unwrap()),
            rz_axis: i16::from_le_bytes(buf[92..94].try_into().unwrap()),
            slider_axis: i16::from_le_bytes(buf[94..96].try_into().unwrap()),
            fw_version: u16::from_le_bytes(buf[96..98].try_into().unwrap()),
        };

        report_feature
    }

    pub fn get_side(&self) -> bool {
        match self.controller_info.as_ref().unwrap().product_id() {
            10 => true,
            11 => false,
            _ => panic!("Not our device or bad product id")
        }
    }

    pub fn get_serial(&self) -> String {
        self.controller_info.as_ref().unwrap().serial_number().unwrap().to_string()
    }

    pub fn set_x(&mut self, value_min: i16, value_max: i16, averaging: u8, dead_zone: u8) {
        self.feature.as_mut().unwrap().x_min = value_min;
        self.feature.as_mut().unwrap().x_max = value_max;
        self.feature.as_mut().unwrap().x_averaging = averaging;
        self.feature.as_mut().unwrap().x_dead_zone = dead_zone;

    }

    pub fn set_y(&mut self, value_min: i16, value_max: i16, averaging: u8, dead_zone: u8) {
        self.feature.as_mut().unwrap().y_min = value_min;
        self.feature.as_mut().unwrap().y_max = value_max;
        self.feature.as_mut().unwrap().y_averaging = averaging;
        self.feature.as_mut().unwrap().y_dead_zone = dead_zone;
    }

    pub fn set_z(&mut self, value_min: i16, value_max: i16, averaging: u8, dead_zone: u8) {
        self.feature.as_mut().unwrap().z_min = value_min;
        self.feature.as_mut().unwrap().z_max = value_max;
        self.feature.as_mut().unwrap().z_averaging = averaging;
        self.feature.as_mut().unwrap().z_dead_zone = dead_zone;
    }

    pub fn set_rx(&mut self, value_min: i16, value_max: i16, averaging: u8, dead_zone: u8) {
        self.feature.as_mut().unwrap().rx_min = value_min;
        self.feature.as_mut().unwrap().rx_max = value_max;
        self.feature.as_mut().unwrap().rx_averaging = averaging;
        self.feature.as_mut().unwrap().rx_dead_zone = dead_zone;
    }

    pub fn set_ry(&mut self, value_min: i16, value_max: i16, averaging: u8, dead_zone: u8) {
        self.feature.as_mut().unwrap().ry_min = value_min;
        self.feature.as_mut().unwrap().ry_max = value_max;
        self.feature.as_mut().unwrap().ry_averaging = averaging;
        self.feature.as_mut().unwrap().ry_dead_zone = dead_zone;
    }

    pub fn set_rz(&mut self, value_min: i16, value_max: i16, averaging: u8, dead_zone: u8) {
        self.feature.as_mut().unwrap().rz_min = value_min;
        self.feature.as_mut().unwrap().rz_max = value_max;
        self.feature.as_mut().unwrap().rz_averaging = averaging;
        self.feature.as_mut().unwrap().rz_dead_zone = dead_zone;
    }

    pub fn set_slider(&mut self, value_min: i16, value_max: i16, averaging: u8, dead_zone: u8) {
        self.feature.as_mut().unwrap().slider_min = value_min;
        self.feature.as_mut().unwrap().slider_max = value_max;
        self.feature.as_mut().unwrap().slider_averaging = averaging;
        self.feature.as_mut().unwrap().slider_dead_zone = dead_zone;
    }

    pub fn set_encoder(&mut self, value: u8) {
        self.feature.as_mut().unwrap().encoder_time = value;
    }

    pub fn set_rgb_led(&mut self, r: u8, g: u8, b: u8) {
        self.feature.as_mut().unwrap().led_r = r;
        self.feature.as_mut().unwrap().led_g = g;
        self.feature.as_mut().unwrap().led_b = b;
    }

    // TODO: add basic check for correctness of the value... but hey it is us so)

    // 0 or 4
    pub fn set_hatka1_mode(&mut self, mode: u8) {
        if (mode != 0 || mode != 4) {
            panic!("Incorrect value");
        }
        self.feature.as_mut().unwrap().hatka1_mode = mode;
    }

    pub fn set_hatka2_mode(&mut self, mode: u8) {
        if let 0 | 1 | 2 | 3 | 4 = mode {
            self.feature.as_mut().unwrap().hatka2_mode = mode;
        } else {
            panic!("Incorrect value")
        }
    }

    pub fn set_hatka3_mode(&mut self, mode: u8) {
        if let 0 | 1 | 2 | 3 | 4 = mode {
            self.feature.as_mut().unwrap().hatka3_mode = mode;
        } else {
            panic!("Incorrect value")
        }
    }

    pub fn set_hatka4_mode(&mut self, mode: u8) {
        if let 0 | 1 | 2 | 3 | 4 = mode {
            self.feature.as_mut().unwrap().hatka4_mode = mode;
        } else {
            panic!("Incorrect value")
        }
    }

    pub fn set_gash1(&mut self, value_min: i16, value_max: i16) {
        self.feature.as_mut().unwrap().gash_button1_min = value_min;
        self.feature.as_mut().unwrap().gash_button1_max = value_max;
    }
    pub fn set_gash2(&mut self, value_min: i16, value_max: i16) {
        self.feature.as_mut().unwrap().gash_button2_min = value_min;
        self.feature.as_mut().unwrap().gash_button2_max = value_max;
    }
    pub fn set_gash3(&mut self, value_min: i16, value_max: i16) {
        self.feature.as_mut().unwrap().gash_button3_min = value_min;
        self.feature.as_mut().unwrap().gash_button3_max = value_max;
    }
    // fn set_control_byte(&self) 
    pub fn set_toggle_lr(&mut self) {
        self.feature.as_mut().unwrap().control_byte ^= 1 << 6;
    }

    pub fn set_enable_dfu(&mut self) {
        self.feature.as_mut().unwrap().control_byte |= 1 << 7;
    }

    pub fn set_enable_calibrate_base(&mut self) {
        self.feature.as_mut().unwrap().control_byte |= 1 << 2;
    }

    pub fn set_enable_calibrate_handle(&mut self) {
        self.feature.as_mut().unwrap().control_byte |= 1 << 3;
    }

    pub fn set_disable_calibrate_handle(&mut self) {
        self.feature.as_mut().unwrap().control_byte &= !(1 << 3);
    }

    pub fn set_disable_calibrate_base(&mut self) {
        self.feature.as_mut().unwrap().control_byte &= !(1 << 2);
    }

    pub fn set_save_config(&mut self) {
        self.feature.as_mut().unwrap().control_byte |= 1 << 0;
    }

    pub fn send_feature(&self) {
        let mut buf: [u8; 129] = [0; 129];
        buf[0] = 2;
        self.feature.as_ref().as_mut().unwrap().to_bytes(&mut buf);
        self.device.as_ref().unwrap().send_feature_report(&buf).unwrap();
    }

    pub fn print_feature(&self) {
        println!("{:?}", self.feature);
    }

    pub fn write_feature(&self) {
        let mut buf: [u8; 129] = [0; 129];
        // buf[0] = 2;

        self.feature.as_ref().as_mut().unwrap().to_bytes(&mut buf);
        buf[0] = 2;
        // self.feature.to_bytes(&mut buf);
        // let mut write_buf: [u8; 178] = [0; 178];
        // let bytes = [
        //     0b00000101, 0b00000001, 0b00001001, 0b00000100, 0b10100001, 0b00000001, 0b10000101, 0b00000001,
        //     0b00000101, 0b00001001, 0b00011001, 0b00000001, 0b00101001, 0b00110000, 0b00010101, 0b00000000,
        //     0b00100101, 0b00000001, 0b01110101, 0b00000001, 0b10010101, 0b00110000, 0b10000001, 0b00000010,
        //     0b00000101, 0b00000001, 0b00001001, 0b00110000, 0b00010101, 0b00000000, 0b00100110, 0b11111111,
        //     0b01111111, 0b01110101, 0b00001111, 0b10010101, 0b00000001, 0b10000001, 0b00000010, 0b01110101,
        //     0b00000001, 0b10010101, 0b00000001, 0b10000001,
        // ];

        // write_buf[..44].copy_from_slice(&bytes);
        // write_buf[44..172].copy_from_slice(&buf);
        // // write_buf[45] = 3;
        // println!("WRITTEN BUFFER: {:?}", write_buf );
        self.device.as_ref().unwrap().send_feature_report(&buf).unwrap();
    }

    // pub fn set_x(&mut self, x_min: u16, x_max: u16) {
    //     self.feature.x_min = x_min;
    //     self.feature.x_max = x_max;
    // }

    // pub fn set_x(&mut self, x_min: u16, x_max: u16) {
    //     self.feature.x_min = x_min;
    //     self.feature.x_max = x_max;
    // }

    pub fn get_control_byte(&self) -> u8 {
        self.feature.as_ref().as_mut().unwrap().control_byte
    }

    pub fn get_x(&self) -> (i16, i16, u8, u8) {
        (
            self.feature.as_ref().as_mut().unwrap().x_min,
            self.feature.as_ref().as_mut().unwrap().x_max,
            self.feature.as_ref().as_mut().unwrap().x_averaging,
            self.feature.as_ref().as_mut().unwrap().x_dead_zone
        )
    }

    pub fn get_y(&self) -> (i16, i16, u8, u8) {
        (
            self.feature.as_ref().as_mut().unwrap().y_min,
            self.feature.as_ref().as_mut().unwrap().y_max,
            self.feature.as_ref().as_mut().unwrap().y_averaging,
            self.feature.as_ref().as_mut().unwrap().y_dead_zone
        )
    }
    
    pub fn write_to_file(&self, file_name: &str) -> Result<()> {
        let json = serde_json::to_string(self.feature.as_ref().unwrap())?;
        let mut file_path = PathBuf::from(BASE_PATH);
        file_path.push(file_name);

        let mut file = OpenOptions::new()
            .write(true)
            .create(true)
            .open(file_path)?;

        file.write_all(json.as_bytes())?;
        Ok(())
    }

    pub fn read_from_file(&mut self, file_name: &str) -> Result<()> {
        let mut file_path = PathBuf::from(BASE_PATH);
        file_path.push(file_name);
        
        let mut file = File::open(file_path)?;
        let mut contents = String::new();
        file.read_to_string(&mut contents)?;
        let report_feature: ReportFeature = serde_json::from_str(&contents)?;

        // TODO: handle control bytes to be reset
        self.feature = Some(report_feature);
        // Ok(report_feature)
        Ok(())
    }

    pub fn list_json_files() -> Result<String> {
        let entries = fs::read_dir(BASE_PATH)?;
        
        let mut file_list = String::new();
    
        for entry in entries {
            let entry = entry?;
            let path = entry.path();
            
            if path.is_file() && path.extension() == Some(std::ffi::OsStr::new("json")) {
                file_list.push_str(&path.display().to_string());
                file_list.push_str(", ");
            }
        }
    
        Ok(file_list)
    }
    
}



#[derive(Clone, Debug)]
pub struct ReportIn {
    pub id: u8,
    pub buttons: u64,
    pub x_axis: u16,
    pub y_axis: u16,
    pub z_axis: u16,
    pub rx_axis: u16,
    pub ry_axis: u16,
    pub rz_axis: u16,
    pub slider_axis: u16,
}

impl ReportIn {
    pub fn to_vec(&self) -> Vec<u8> {
        let mut bytes = Vec::with_capacity(27); // total byte size of the struct
        bytes.write_u8(self.id).unwrap();
        bytes.write_u64::<LittleEndian>(self.buttons).unwrap();
        bytes.write_u16::<LittleEndian>(self.x_axis).unwrap();
        bytes.write_u16::<LittleEndian>(self.y_axis).unwrap();
        bytes.write_u16::<LittleEndian>(self.z_axis).unwrap();
        bytes.write_u16::<LittleEndian>(self.rx_axis).unwrap();
        bytes.write_u16::<LittleEndian>(self.ry_axis).unwrap();
        bytes.write_u16::<LittleEndian>(self.rz_axis).unwrap();
        bytes.write_u16::<LittleEndian>(self.slider_axis).unwrap();

        bytes
    }
}

// impl IntoIntoDart<(u8, u64, u16, u16, u16, u16, u16, u16, u16)> for ReportIn {
//     fn into_into_dart(self) -> (u8, u64, u16, u16, u16, u16, u16, u16, u16) {
//         (
//             self.id,
//             self.buttons,
//             self.x_axis,
//             self.y_axis,
//             self.z_axis,
//             self.rx_axis,
//             self.ry_axis,
//             self.rz_axis,
//             self.slider_axis
//         )
//     }
// }

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct ReportFeature {
    pub id: u8,
    pub x_min: i16,
    pub _x_centr: i16,
    pub x_max: i16,
    pub x_averaging: u8,
    pub x_dead_zone: u8,
    pub y_min: i16,
    pub _y_centr: i16,
    pub y_max: i16,
    pub y_averaging: u8,
    pub y_dead_zone: u8,
    pub z_min: i16,
    pub _z_centr: i16,
    pub z_max: i16,
    pub z_averaging: u8,
    pub z_dead_zone: u8,
    pub rx_min: i16,
    pub _rx_centr: i16,
    pub rx_max: i16,
    pub rx_averaging: u8,
    pub rx_dead_zone: u8,
    pub ry_min: i16,
    pub _ry_centr: i16,
    pub ry_max: i16,
    pub ry_averaging: u8,
    pub ry_dead_zone: u8,
    pub rz_min: i16,
    pub rz_max: i16,
    pub rz_averaging: u8,
    pub rz_dead_zone: u8,
    pub slider_min: i16,
    pub slider_max: i16,
    pub slider_averaging: u8,
    pub slider_dead_zone: u8,
    pub encoder_time: u8,
    pub led_r: u8,
    pub led_g: u8,
    pub led_b: u8,
    pub id_grib: u8,
    pub hatka1_mode: u8,
    pub hatka2_mode: u8,
    pub hatka3_mode: u8,
    pub hatka4_mode: u8,
    pub control_byte: u8,
    pub gash_button1_min: i16,
    pub gash_button1_max: i16,
    pub gash_button2_min: i16,
    pub gash_button2_max: i16,
    pub gash_button3_min: i16,
    pub gash_button3_max: i16,
    pub spi_error_cnt: u8,
    //below are real values received
    pub buttons: u64,
    pub x_axis: i16,
    pub y_axis: i16,
    pub z_axis: i16,
    pub rx_axis: i16,
    pub ry_axis: i16,
    pub rz_axis: i16,
    pub slider_axis: i16,
    pub fw_version: u16,
}

impl Default for ReportFeature {
    fn default() -> ReportFeature {
        ReportFeature { id: 0, x_min: 0, _x_centr: 0, x_max: 0, x_averaging: 0, x_dead_zone: 0, y_min: 0, _y_centr: 0, y_max: 0, y_averaging: 0, y_dead_zone: 0, z_min: 0, _z_centr: 0, z_max: 0, z_averaging: 0, z_dead_zone: 0, rx_min: 0, _rx_centr: 0, rx_max: 0, rx_averaging: 0, rx_dead_zone: 0, ry_min: 0, _ry_centr: 0, ry_max: 0, ry_averaging: 0, ry_dead_zone: 0, rz_min: 0, rz_max: 0, rz_averaging: 0, rz_dead_zone: 0, slider_min: 0, slider_max: 0, slider_averaging: 0, slider_dead_zone: 0, encoder_time: 0, led_r: 0, led_g: 0, led_b: 0, id_grib: 0, hatka1_mode: 0, hatka2_mode: 0, hatka3_mode: 0, hatka4_mode: 0, control_byte: 0, gash_button1_min: 0, gash_button1_max: 0, gash_button2_min: 0, gash_button2_max: 0, gash_button3_min: 0, gash_button3_max: 0, spi_error_cnt: 0, buttons: 0, x_axis: 0, y_axis: 0, z_axis: 0, rx_axis: 0, ry_axis: 0, rz_axis: 0, slider_axis: 0, fw_version: 0 }
    }
}

impl Default for ReportIn {
    fn default() -> ReportIn {
        ReportIn { id: 0, buttons: 0, x_axis: 50, y_axis: 50, z_axis: 59, rx_axis: 50, ry_axis: 50, rz_axis: 50, slider_axis: 50 }
    }
}

impl ReportFeature {
    fn to_bytes(&self, buf: &mut [u8; 129]) {
        buf[0] = self.id;
        buf[1..3].copy_from_slice(&to_bytes_from_i16(self.x_min));
        buf[3..5].copy_from_slice(&to_bytes_from_i16(self._x_centr));
        buf[5..7].copy_from_slice(&to_bytes_from_i16(self.x_max));
        buf[7..8].copy_from_slice(&to_bytes_from_u8(self.x_averaging));
        buf[8..9].copy_from_slice(&to_bytes_from_u8(self.x_dead_zone));
        buf[9..11].copy_from_slice(&to_bytes_from_i16(self.y_min));
        buf[11..13].copy_from_slice(&to_bytes_from_i16(self._y_centr));
        buf[13..15].copy_from_slice(&to_bytes_from_i16(self.y_max));
        buf[15..16].copy_from_slice(&to_bytes_from_u8(self.y_averaging));
        buf[16..17].copy_from_slice(&to_bytes_from_u8(self.y_dead_zone));
        buf[17..19].copy_from_slice(&to_bytes_from_i16(self.z_min));
        buf[19..21].copy_from_slice(&to_bytes_from_i16(self._z_centr));
        buf[21..23].copy_from_slice(&to_bytes_from_i16(self.z_max));
        buf[23..24].copy_from_slice(&to_bytes_from_u8(self.z_averaging));
        buf[24..25].copy_from_slice(&to_bytes_from_u8(self.z_dead_zone));
        buf[25..27].copy_from_slice(&to_bytes_from_i16(self.rx_min));
        buf[27..29].copy_from_slice(&to_bytes_from_i16(self._rx_centr));
        buf[29..31].copy_from_slice(&to_bytes_from_i16(self.rx_max));
        buf[31..32].copy_from_slice(&to_bytes_from_u8(self.rx_averaging));
        buf[32..33].copy_from_slice(&to_bytes_from_u8(self.rx_dead_zone));
        buf[33..35].copy_from_slice(&to_bytes_from_i16(self.ry_min));
        buf[35..37].copy_from_slice(&to_bytes_from_i16(self._ry_centr));
        buf[37..39].copy_from_slice(&to_bytes_from_i16(self.ry_max));
        buf[39..40].copy_from_slice(&to_bytes_from_u8(self.ry_averaging));
        buf[40..41].copy_from_slice(&to_bytes_from_u8(self.ry_dead_zone));
        buf[41..43].copy_from_slice(&to_bytes_from_i16(self.rz_min));

        buf[43..45].copy_from_slice(&to_bytes_from_i16(self.rz_max));
        buf[45..46].copy_from_slice(&to_bytes_from_u8(self.rz_averaging));
        buf[46..47].copy_from_slice(&to_bytes_from_u8(self.rz_dead_zone));
        buf[47..49].copy_from_slice(&to_bytes_from_i16(self.slider_min));
        buf[49..51].copy_from_slice(&to_bytes_from_i16(self.slider_max));
        buf[51..52].copy_from_slice(&to_bytes_from_u8(self.slider_averaging));
        buf[52..53].copy_from_slice(&to_bytes_from_u8(self.slider_dead_zone));
        buf[53..54].copy_from_slice(&to_bytes_from_u8(self.encoder_time));
        buf[54..55].copy_from_slice(&to_bytes_from_u8(self.led_r));
        buf[55..56].copy_from_slice(&to_bytes_from_u8(self.led_g));
        buf[56..57].copy_from_slice(&to_bytes_from_u8(self.led_b));
        buf[57..58].copy_from_slice(&to_bytes_from_u8(self.id_grib));
        buf[58..59].copy_from_slice(&to_bytes_from_u8(self.hatka1_mode));
        buf[59..60].copy_from_slice(&to_bytes_from_u8(self.hatka2_mode));
        buf[60..61].copy_from_slice(&to_bytes_from_u8(self.hatka3_mode));
        buf[61..62].copy_from_slice(&to_bytes_from_u8(self.hatka4_mode));
        buf[62..63].copy_from_slice(&to_bytes_from_u8(self.control_byte));
        buf[63..65].copy_from_slice(&to_bytes_from_i16(self.gash_button1_min));
        buf[65..67].copy_from_slice(&to_bytes_from_i16(self.gash_button1_max));
        buf[67..69].copy_from_slice(&to_bytes_from_i16(self.gash_button2_min));
        buf[69..71].copy_from_slice(&to_bytes_from_i16(self.gash_button2_max));
        buf[71..73].copy_from_slice(&to_bytes_from_i16(self.gash_button3_min));
        buf[73..75].copy_from_slice(&to_bytes_from_i16(self.gash_button3_max));
        buf[75..76].copy_from_slice(&to_bytes_from_u8(self.spi_error_cnt));
        buf[76..82].copy_from_slice(&to_bytes_from_u64(self.buttons));
        buf[82..84].copy_from_slice(&to_bytes_from_i16(self.x_axis));
        buf[84..86].copy_from_slice(&to_bytes_from_i16(self.y_axis));
        buf[86..88].copy_from_slice(&to_bytes_from_i16(self.z_axis));
        buf[88..90].copy_from_slice(&to_bytes_from_i16(self.rx_axis));
        buf[90..92].copy_from_slice(&to_bytes_from_i16(self.ry_axis));
        buf[92..94].copy_from_slice(&to_bytes_from_i16(self.rz_axis));
        buf[94..96].copy_from_slice(&to_bytes_from_i16(self.slider_axis));
        buf[96..98].copy_from_slice(&to_bytes_from_u16(self.fw_version));
    }
}
    
fn to_bytes_from_u16(value: u16) -> [u8; 2] {
     value.to_le_bytes()  
}

fn to_bytes_from_i16(value: i16) -> [u8; 2] {
    value.to_le_bytes()  
}

fn to_bytes_from_u8(value: u8) -> [u8; 1] {
    [value]
}

fn to_bytes_from_u64(value: u64) -> [u8; 6] {
    let mut bytes = [0u8; 6];
    for i in 0..6 {
        bytes[i] = ((value >> (i * 8)) & 0xFF) as u8;
    }
    bytes
}



type ReportFeatureTuple = (
    u8, u16, u16, u16, u8, u8, u16, u16, u16, u8, u8,
    u16, u16, u16, u8, u8, u16, u16, u16, u8, u8,
    u16, u16, u16, u8, u8, u16, u16, u16, u8, u8,
    u16, u16, u8, u8, u8, u8, u8, u8, u8, u8, u8,
    u8, u16, u16, u16, u16, u16, u16, u8, u64,
    u16, u16, u16, u16, u16, u16, u16, u16
);

// fn get_device() -> Result<HidDevice> {
//    api.open()

// }

pub fn get_controller_info <'a>() -> Result<DeviceInfo> {
    let api = hidapi::HidApi::new().unwrap();
    let matching_device = api
        .device_list()
        .into_iter()
        .find(|&device| device.vendor_id() == VENDOR_ID_CONST).unwrap();
    // let bmd = Box::new(matching_device);
    // Ok(Box::leak(bmd))
    let md = matching_device.clone();
    Ok(md)
}

// pub fn our_check() -> Result<bool> {
//     match get_controller() {
//         Ok(device_info) => match device_info.vendor_id() {
//             VENDOR_ID_CONST => Ok(true),
//             _ => Ok(false),
//         },
//         Err(e) => Err(e),
//     }
// }

// pub fn get_side() -> Result<u16> {
//     Ok(get_controller().unwrap().product_id())
// }

// TODO: result buffer and tuple is pre-made and passed
fn get_data(
    device: &HidDevice   // TODO: with bridge need to reconnect everytime, unless i can somehow preserve the state
// ) -> Result<(
//     u8,
//     u64, // For 6 bytes
//     u16,
//     u16,
//     u16,
//     u16,
//     u16,
//     u16,
//     u16,
// )> {
) -> Result<
    ReportIn
> {

    // let api = hidapi::HidApi::new().unwrap();
    // let controller = get_controller().unwrap();
    // let device = api.open(controller.vendor_id(), controller.product_id()).unwrap();
    let mut buf = [0u8; 21];
    let res = device.read(&mut buf[..]).unwrap();
    let report_in = ReportIn {
            id: buf[0],
            buttons: to_u64_from_6_bytes(buf[1..7].try_into().unwrap()),
            x_axis: u16::from_le_bytes(buf[7..9].try_into().unwrap()),
            y_axis: u16::from_le_bytes(buf[9..11].try_into().unwrap()),
            z_axis: u16::from_le_bytes(buf[11..13].try_into().unwrap()),
            rx_axis: u16::from_le_bytes(buf[13..15].try_into().unwrap()),
            ry_axis: u16::from_le_bytes(buf[15..17].try_into().unwrap()),
            rz_axis: u16::from_le_bytes(buf[17..19].try_into().unwrap()),
            slider_axis: u16::from_le_bytes(buf[19..21].try_into().unwrap()),
        };
    // let segments: (
    //     u8, 
    //     u64,  // For 6 bytes 
    //     u16, 
    //     u16, 
    //     u16, 
    //     u16, 
    //     u16, 
    //     u16, 
    //     u16
    // ) = (
    //     buf[0],
    //     to_u64_from_6_bytes(&buf[1..7]),
    //     u16::from_le_bytes(buf[7..9].try_into().unwrap()),
    //     u16::from_le_bytes(buf[9..11].try_into().unwrap()),
    //     u16::from_le_bytes(buf[11..13].try_into().unwrap()),
    //     u16::from_le_bytes(buf[13..15].try_into().unwrap()),
    //     u16::from_le_bytes(buf[15..17].try_into().unwrap()),
    //     u16::from_le_bytes(buf[17..19].try_into().unwrap()),
    //     u16::from_le_bytes(buf[19..21].try_into().unwrap())
    // );
    // Ok(segments)
    Ok(report_in)
}

fn get_report(
    device: &HidDevice
) -> Result<ReportFeature> {
    // let api = hidapi::HidApi::new().unwrap();

    // let controller = get_controller().unwrap();
    // let device = api.open(controller.vendor_id(), controller.product_id()).unwrap();

    let mut buf: [u8; 129] = [0; 129];
    buf[0] = 2;
    let res = device.get_feature_report(&mut buf).unwrap();
    // let res = device.get_feature_report(&mut buf).unwrap();

    let report_feature = ReportFeature {
        id: buf[0],
        x_min: i16::from_le_bytes(buf[1..3].try_into().unwrap()),
        _x_centr: i16::from_le_bytes(buf[3..5].try_into().unwrap()),
        x_max: i16::from_le_bytes(buf[5..7].try_into().unwrap()),
        x_averaging: u8::from_le_bytes(buf[7..8].try_into().unwrap()),
        x_dead_zone: u8::from_le_bytes(buf[8..9].try_into().unwrap()),
        y_min: i16::from_le_bytes(buf[9..11].try_into().unwrap()),
        _y_centr: i16::from_le_bytes(buf[11..13].try_into().unwrap()),
        y_max: i16::from_le_bytes(buf[13..15].try_into().unwrap()),
        y_averaging: u8::from_le_bytes(buf[15..16].try_into().unwrap()),
        y_dead_zone: u8::from_le_bytes(buf[16..17].try_into().unwrap()),
        z_min: i16::from_le_bytes(buf[17..19].try_into().unwrap()),
        _z_centr: i16::from_le_bytes(buf[19..21].try_into().unwrap()),
        z_max: i16::from_le_bytes(buf[21..23].try_into().unwrap()),
        z_averaging: u8::from_le_bytes(buf[23..24].try_into().unwrap()),
        z_dead_zone: u8::from_le_bytes(buf[24..25].try_into().unwrap()),
        rx_min: i16::from_le_bytes(buf[25..27].try_into().unwrap()),
        _rx_centr: i16::from_le_bytes(buf[27..29].try_into().unwrap()),
        rx_max: i16::from_le_bytes(buf[29..31].try_into().unwrap()),
        rx_averaging: u8::from_le_bytes(buf[31..32].try_into().unwrap()),
        rx_dead_zone: u8::from_le_bytes(buf[32..33].try_into().unwrap()),
        ry_min: i16::from_le_bytes(buf[33..35].try_into().unwrap()),
        _ry_centr: i16::from_le_bytes(buf[35..37].try_into().unwrap()),
        ry_max: i16::from_le_bytes(buf[37..39].try_into().unwrap()),
        ry_averaging: u8::from_le_bytes(buf[39..40].try_into().unwrap()),
        ry_dead_zone: u8::from_le_bytes(buf[40..41].try_into().unwrap()),
        rz_min: i16::from_le_bytes(buf[41..43].try_into().unwrap()),
        rz_max: i16::from_le_bytes(buf[43..45].try_into().unwrap()),
        rz_averaging: u8::from_le_bytes(buf[45..46].try_into().unwrap()),
        rz_dead_zone: u8::from_le_bytes(buf[46..47].try_into().unwrap()),
        slider_min: i16::from_le_bytes(buf[47..49].try_into().unwrap()),
        slider_max: i16::from_le_bytes(buf[49..51].try_into().unwrap()),
        slider_averaging: u8::from_le_bytes(buf[51..52].try_into().unwrap()),
        slider_dead_zone: u8::from_le_bytes(buf[52..53].try_into().unwrap()),
        encoder_time: u8::from_le_bytes(buf[53..54].try_into().unwrap()),
        led_r: u8::from_le_bytes(buf[54..55].try_into().unwrap()),
        led_g: u8::from_le_bytes(buf[55..56].try_into().unwrap()),
        led_b: u8::from_le_bytes(buf[56..57].try_into().unwrap()),
        id_grib: u8::from_le_bytes(buf[57..58].try_into().unwrap()),
        hatka1_mode: u8::from_le_bytes(buf[58..59].try_into().unwrap()),
        hatka2_mode: u8::from_le_bytes(buf[59..60].try_into().unwrap()),
        hatka3_mode: u8::from_le_bytes(buf[60..61].try_into().unwrap()),
        hatka4_mode: u8::from_le_bytes(buf[61..62].try_into().unwrap()),
        control_byte: u8::from_le_bytes(buf[62..63].try_into().unwrap()),
        gash_button1_min: i16::from_le_bytes(buf[63..65].try_into().unwrap()),
        gash_button1_max: i16::from_le_bytes(buf[65..67].try_into().unwrap()),
        gash_button2_min: i16::from_le_bytes(buf[67..69].try_into().unwrap()),
        gash_button2_max: i16::from_le_bytes(buf[69..71].try_into().unwrap()),
        gash_button3_min: i16::from_le_bytes(buf[71..73].try_into().unwrap()),
        gash_button3_max: i16::from_le_bytes(buf[73..75].try_into().unwrap()),
        spi_error_cnt: u8::from_le_bytes(buf[75..76].try_into().unwrap()),
        buttons: to_u64_from_6_bytes(buf[76..82].try_into().unwrap()),
        x_axis: i16::from_le_bytes(buf[82..84].try_into().unwrap()),
        y_axis: i16::from_le_bytes(buf[84..86].try_into().unwrap()),
        z_axis: i16::from_le_bytes(buf[86..88].try_into().unwrap()),
        rx_axis: i16::from_le_bytes(buf[88..90].try_into().unwrap()),
        ry_axis: i16::from_le_bytes(buf[90..92].try_into().unwrap()),
        rz_axis: i16::from_le_bytes(buf[92..94].try_into().unwrap()),
        slider_axis: i16::from_le_bytes(buf[94..96].try_into().unwrap()),
        fw_version: u16::from_le_bytes(buf[96..98].try_into().unwrap()),
    };

    // println!("Read: {:?}", &buf[..res]);
    // println!("Feature report: {:?}",report_feature);
    Ok(report_feature)
}

fn to_u64_from_6_bytes(slice: &[u8]) -> u64 {
    let mut arr = [0u8; 8];  // default to an 8-byte array for u64
    arr[2..].copy_from_slice(slice);
    u64::from_le_bytes(arr)
}