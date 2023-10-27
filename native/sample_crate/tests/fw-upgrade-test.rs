use sample_crate::firmware::upgrade_firmware;




#[test]
fn fw_upgrade() {
    let mut device = sample_crate::DeviceState::new();
    println!("{:?}", device.feature);
    device.set_enable_dfu();
    upgrade_firmware("none in debug".to_string());
}