


#[test]
fn fw_upgrade() {
    let mut device = sample_crate::DeviceState::new();
    println!("{:?}", device.feature);
    device.set_enable_dfu();
    
}