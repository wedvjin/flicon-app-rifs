extern crate hidapi;
use anyhow::{anyhow, Result};
use hidapi::{DeviceInfo, HidDevice};

use byteorder::{LittleEndian, WriteBytesExt};

const VENDOR_ID_CONST: u16 = 13911;

pub struct DeviceState {
    device: Box<HidDevice>,
    controller_info: DeviceInfo,
    feature: ReportFeature,
}

impl DeviceState {
    pub fn new() -> Self {
        let api = hidapi::HidApi::new().unwrap();
        let controller_info = api
            .device_list()
            .into_iter()
            .find(|&device| device.vendor_id() == VENDOR_ID_CONST).unwrap();
        // let bmd = Box::new(matching_device);
        // Ok(Box::leak(bmd))
        // let md = matching_device.clone();

        let device = api.open(controller_info.vendor_id(), controller_info.product_id()).unwrap();
        let boxed_device = Box::new(device);
        let feautre_report = ReportFeature {
            ..Default::default()
        };
        DeviceState { device: boxed_device, controller_info: controller_info.clone(), feature: feautre_report}
    }

    // SHALL BE CALLED TO SET THE REPORT WORKAROUND FOR NOW
    pub fn set_report_internal(&mut self) {
        self.feature = get_report(&self.device).unwrap();
    }

    pub fn get_data(&self) -> ReportIn {
        get_data(&self.device).unwrap()
    }

    pub fn get_report(&self) -> ReportFeature {
        get_report(&self.device).unwrap()
    }

    pub fn get_side(&self) -> bool {
        match self.controller_info.product_id() {
            10 => true,
            11 => false,
            _ => panic!("Not our device or bad product id")
        }
    }

    pub fn get_serial(&self) -> String {
        self.controller_info.serial_number().unwrap().to_string()
    }

    pub fn set_x(&mut self, value_min: u16, value_max: u16, averaging: u8, dead_zone: u8) {
        self.feature.x_min = value_min;
        self.feature.x_max = value_max;
        self.feature.x_averaging = averaging;
        self.feature.x_dead_zone = dead_zone;

    }

    pub fn set_y(&mut self, value_min: u16, value_max: u16, averaging: u8, dead_zone: u8) {
        self.feature.y_min = value_min;
        self.feature.y_max = value_max;
        self.feature.y_averaging = averaging;
        self.feature.y_dead_zone = dead_zone;
    }

    pub fn set_z(&mut self, value_min: u16, value_max: u16, averaging: u8, dead_zone: u8) {
        self.feature.z_min = value_min;
        self.feature.z_max = value_max;
        self.feature.z_averaging = averaging;
        self.feature.z_dead_zone = dead_zone;
    }

    pub fn set_rx(&mut self, value_min: u16, value_max: u16, averaging: u8, dead_zone: u8) {
        self.feature.rx_min = value_min;
        self.feature.rx_max = value_max;
        self.feature.rx_averaging = averaging;
        self.feature.rx_dead_zone = dead_zone;
    }

    pub fn set_ry(&mut self, value_min: u16, value_max: u16, averaging: u8, dead_zone: u8) {
        self.feature.ry_min = value_min;
        self.feature.ry_max = value_max;
        self.feature.ry_averaging = averaging;
        self.feature.ry_dead_zone = dead_zone;
    }

    pub fn set_rz(&mut self, value_min: u16, value_max: u16, averaging: u8, dead_zone: u8) {
        self.feature.rz_min = value_min;
        self.feature.rz_max = value_max;
        self.feature.rz_averaging = averaging;
        self.feature.rz_dead_zone = dead_zone;
    }

    pub fn set_slider(&mut self, value_min: u16, value_max: u16, averaging: u8, dead_zone: u8) {
        self.feature.slider_min = value_min;
        self.feature.slider_max = value_max;
        self.feature.slider_averaging = averaging;
        self.feature.slider_dead_zone = dead_zone;
    }

    pub fn set_encoder(&mut self, value: u8) {
        self.feature.encoder_time = value;
    }

    pub fn set_rgb_led(&mut self, r: u8, g: u8, b: u8) {
        self.feature.led_r = r;
        self.feature.led_g = g;
        self.feature.led_b = b;
    }

    // TODO: add basic check for correctness of the value... but hey it is us so)

    // 0 or 4
    pub fn set_hatka1_mode(&mut self, mode: u8) {
        if (mode != 0 || mode != 4) {
            panic!("Incorrect value");
        }
        self.feature.hatka1_mode = mode;
    }

    pub fn set_hatka2_mode(&mut self, mode: u8) {
        if let 0 | 1 | 2 | 3 | 4 = mode {
            self.feature.hatka2_mode = mode;
        } else {
            panic!("Incorrect value")
        }
    }

    pub fn set_hatka3_mode(&mut self, mode: u8) {
        if let 0 | 1 | 2 | 3 | 4 = mode {
            self.feature.hatka3_mode = mode;
        } else {
            panic!("Incorrect value")
        }
    }

    pub fn set_hatka4_mode(&mut self, mode: u8) {
        if let 0 | 1 | 2 | 3 | 4 = mode {
            self.feature.hatka4_mode = mode;
        } else {
            panic!("Incorrect value")
        }
    }

    // fn set_control_byte 


    // pub fn write_feature(&self) {

    // }

    // pub fn set_x(&mut self, x_min: u16, x_max: u16) {
    //     self.feature.x_min = x_min;
    //     self.feature.x_max = x_max;
    // }

    // pub fn set_x(&mut self, x_min: u16, x_max: u16) {
    //     self.feature.x_min = x_min;
    //     self.feature.x_max = x_max;
    // }
    
}

#[derive(Clone, Debug)]
pub struct ReportIn {
    id: u8,
    buttons: u64,
    x_axis: u16,
    y_axis: u16,
    z_axis: u16,
    rx_axis: u16,
    ry_axis: u16,
    rz_axis: u16,
    slider_axis: u16,
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

#[derive(Clone, Debug)]
pub struct ReportFeature {
    id: u8,
    x_min: u16,
    _x_centr: u16,
    x_max: u16,
    x_averaging: u8,
    x_dead_zone: u8,
    y_min: u16,
    _y_centr: u16,
    y_max: u16,
    y_averaging: u8,
    y_dead_zone: u8,
    z_min: u16,
    _z_centr: u16,
    z_max: u16,
    z_averaging: u8,
    z_dead_zone: u8,
    rx_min: u16,
    _rx_centr: u16,
    rx_max: u16,
    rx_averaging: u8,
    rx_dead_zone: u8,
    ry_min: u16,
    _ry_centr: u16,
    ry_max: u16,
    ry_averaging: u8,
    ry_dead_zone: u8,
    rz_min: u16,
    _rz_centr: u16,
    rz_max: u16,
    rz_averaging: u8,
    rz_dead_zone: u8,
    slider_min: u16,
    slider_max: u16,
    slider_averaging: u8,
    slider_dead_zone: u8,
    encoder_time: u8,
    led_r: u8,
    led_g: u8,
    led_b: u8,
    hatka1_mode: u8,
    hatka2_mode: u8,
    hatka3_mode: u8,
    hatka4_mode: u8,
    control_byte: u8,
    gash_button1_min: u16,
    gash_button1_max: u16,
    gash_button2_min: u16,
    gash_button2_max: u16,
    gash_button3_min: u16,
    gash_button3_max: u16,
    spi_error_cnt: u8,
    //below are real values received
    buttons: u64,
    x_axis: u16,
    y_axis: u16,
    z_axis: u16,
    rx_axis: u16,
    ry_axis: u16,
    rz_axis: u16,
    slider_axis: u16,
    fw_version: u16,
}

impl Default for ReportFeature {
    fn default() -> ReportFeature {
        ReportFeature { id: 0, x_min: 0, _x_centr: 0, x_max: 0, x_averaging: 0, x_dead_zone: 0, y_min: 0, _y_centr: 0, y_max: 0, y_averaging: 0, y_dead_zone: 0, z_min: 0, _z_centr: 0, z_max: 0, z_averaging: 0, z_dead_zone: 0, rx_min: 0, _rx_centr: 0, rx_max: 0, rx_averaging: 0, rx_dead_zone: 0, ry_min: 0, _ry_centr: 0, ry_max: 0, ry_averaging: 0, ry_dead_zone: 0, rz_min: 0, _rz_centr: 0, rz_max: 0, rz_averaging: 0, rz_dead_zone: 0, slider_min: 0, slider_max: 0, slider_averaging: 0, slider_dead_zone: 0, encoder_time: 0, led_r: 0, led_g: 0, led_b: 0, hatka1_mode: 0, hatka2_mode: 0, hatka3_mode: 0, hatka4_mode: 0, control_byte: 0, gash_button1_min: 0, gash_button1_max: 0, gash_button2_min: 0, gash_button2_max: 0, gash_button3_min: 0, gash_button3_max: 0, spi_error_cnt: 0, buttons: 0, x_axis: 0, y_axis: 0, z_axis: 0, rx_axis: 0, ry_axis: 0, rz_axis: 0, slider_axis: 0, fw_version: 0 }
    }
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

    let mut buf: [u8; 128] = [0; 128];
    buf[0] = 3;
    let res = device.get_report_descriptor(&mut buf).unwrap();
    let report_feature = ReportFeature {
        id: buf[0],
        x_min: u16::from_le_bytes(buf[1..3].try_into().unwrap()),
        _x_centr: u16::from_le_bytes(buf[3..5].try_into().unwrap()),
        x_max: u16::from_le_bytes(buf[5..7].try_into().unwrap()),
        x_averaging: u8::from_le_bytes(buf[7..8].try_into().unwrap()),
        x_dead_zone: u8::from_le_bytes(buf[8..9].try_into().unwrap()),
        y_min: u16::from_le_bytes(buf[9..11].try_into().unwrap()),
        _y_centr: u16::from_le_bytes(buf[11..13].try_into().unwrap()),
        y_max: u16::from_le_bytes(buf[13..15].try_into().unwrap()),
        y_averaging: u8::from_le_bytes(buf[15..16].try_into().unwrap()),
        y_dead_zone: u8::from_le_bytes(buf[16..17].try_into().unwrap()),
        z_min: u16::from_le_bytes(buf[17..19].try_into().unwrap()),
        _z_centr: u16::from_le_bytes(buf[19..21].try_into().unwrap()),
        z_max: u16::from_le_bytes(buf[21..23].try_into().unwrap()),
        z_averaging: u8::from_le_bytes(buf[23..24].try_into().unwrap()),
        z_dead_zone: u8::from_le_bytes(buf[24..25].try_into().unwrap()),
        rx_min: u16::from_le_bytes(buf[25..27].try_into().unwrap()),
        _rx_centr: u16::from_le_bytes(buf[27..29].try_into().unwrap()),
        rx_max: u16::from_le_bytes(buf[29..31].try_into().unwrap()),
        rx_averaging: u8::from_le_bytes(buf[31..32].try_into().unwrap()),
        rx_dead_zone: u8::from_le_bytes(buf[32..33].try_into().unwrap()),
        ry_min: u16::from_le_bytes(buf[33..35].try_into().unwrap()),
        _ry_centr: u16::from_le_bytes(buf[35..37].try_into().unwrap()),
        ry_max: u16::from_le_bytes(buf[37..39].try_into().unwrap()),
        ry_averaging: u8::from_le_bytes(buf[39..40].try_into().unwrap()),
        ry_dead_zone: u8::from_le_bytes(buf[40..41].try_into().unwrap()),
        rz_min: u16::from_le_bytes(buf[41..43].try_into().unwrap()),
        _rz_centr: u16::from_le_bytes(buf[43..45].try_into().unwrap()),
        rz_max: u16::from_le_bytes(buf[45..47].try_into().unwrap()),
        rz_averaging: u8::from_le_bytes(buf[47..48].try_into().unwrap()),
        rz_dead_zone: u8::from_le_bytes(buf[48..49].try_into().unwrap()),
        slider_min: u16::from_le_bytes(buf[49..51].try_into().unwrap()),
        slider_max: u16::from_le_bytes(buf[51..53].try_into().unwrap()),
        slider_averaging: u8::from_le_bytes(buf[53..54].try_into().unwrap()),
        slider_dead_zone: u8::from_le_bytes(buf[54..55].try_into().unwrap()),
        encoder_time: u8::from_le_bytes(buf[55..56].try_into().unwrap()),
        led_r: u8::from_le_bytes(buf[56..57].try_into().unwrap()),
        led_g: u8::from_le_bytes(buf[57..58].try_into().unwrap()),
        led_b: u8::from_le_bytes(buf[58..59].try_into().unwrap()),
        hatka1_mode: u8::from_le_bytes(buf[59..60].try_into().unwrap()),
        hatka2_mode: u8::from_le_bytes(buf[60..61].try_into().unwrap()),
        hatka3_mode: u8::from_le_bytes(buf[61..62].try_into().unwrap()),
        hatka4_mode: u8::from_le_bytes(buf[62..63].try_into().unwrap()),
        control_byte: u8::from_le_bytes(buf[63..64].try_into().unwrap()),
        gash_button1_min: u16::from_le_bytes(buf[64..66].try_into().unwrap()),
        gash_button1_max: u16::from_le_bytes(buf[66..68].try_into().unwrap()),
        gash_button2_min: u16::from_le_bytes(buf[68..70].try_into().unwrap()),
        gash_button2_max: u16::from_le_bytes(buf[70..72].try_into().unwrap()),
        gash_button3_min: u16::from_le_bytes(buf[72..74].try_into().unwrap()),
        gash_button3_max: u16::from_le_bytes(buf[74..76].try_into().unwrap()),
        spi_error_cnt: u8::from_le_bytes(buf[76..77].try_into().unwrap()),
        //below are real values received
        buttons: to_u64_from_6_bytes(buf[77..83].try_into().unwrap()),
        x_axis: u16::from_le_bytes(buf[83..85].try_into().unwrap()),
        y_axis: u16::from_le_bytes(buf[85..87].try_into().unwrap()),
        z_axis: u16::from_le_bytes(buf[87..89].try_into().unwrap()),
        rx_axis: u16::from_le_bytes(buf[89..91].try_into().unwrap()),
        ry_axis: u16::from_le_bytes(buf[91..93].try_into().unwrap()),
        rz_axis: u16::from_le_bytes(buf[93..95].try_into().unwrap()),
        slider_axis: u16::from_le_bytes(buf[95..97].try_into().unwrap()),
        fw_version: u16::from_le_bytes(buf[97..99].try_into().unwrap()),
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