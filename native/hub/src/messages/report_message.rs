// @generated
#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct ReportMessage {
    #[prost(uint32, tag="1")]
    pub id: u32,
    #[prost(uint64, tag="2")]
    pub buttons: u64,
    #[prost(uint32, tag="3")]
    pub x: u32,
    #[prost(uint32, tag="4")]
    pub y: u32,
    #[prost(uint32, tag="5")]
    pub z: u32,
    #[prost(uint32, tag="6")]
    pub rx: u32,
    #[prost(uint32, tag="7")]
    pub ry: u32,
    #[prost(uint32, tag="8")]
    pub rz: u32,
    #[prost(uint32, tag="9")]
    pub slider: u32,
    #[prost(bool, tag="10")]
    pub b1: bool,
    #[prost(bool, tag="11")]
    pub b2: bool,
    #[prost(bool, tag="12")]
    pub b3: bool,
    #[prost(bool, tag="13")]
    pub b4: bool,
    #[prost(bool, tag="14")]
    pub b5: bool,
    #[prost(bool, tag="15")]
    pub b6: bool,
    #[prost(bool, tag="16")]
    pub b7: bool,
    #[prost(bool, tag="17")]
    pub b8: bool,
    #[prost(bool, tag="18")]
    pub b9: bool,
    #[prost(bool, tag="19")]
    pub b10: bool,
    #[prost(bool, tag="20")]
    pub b11: bool,
    #[prost(bool, tag="21")]
    pub b12: bool,
    #[prost(bool, tag="22")]
    pub b13: bool,
    #[prost(bool, tag="23")]
    pub b14: bool,
    #[prost(bool, tag="24")]
    pub b15: bool,
    #[prost(bool, tag="25")]
    pub b16: bool,
    #[prost(bool, tag="26")]
    pub b17: bool,
    #[prost(bool, tag="27")]
    pub b18: bool,
    #[prost(bool, tag="28")]
    pub b19: bool,
    #[prost(bool, tag="29")]
    pub b20: bool,
    #[prost(bool, tag="30")]
    pub b21: bool,
    #[prost(bool, tag="31")]
    pub b22: bool,
    #[prost(bool, tag="32")]
    pub b23: bool,
    #[prost(bool, tag="33")]
    pub b24: bool,
    #[prost(bool, tag="34")]
    pub b25: bool,
    #[prost(bool, tag="35")]
    pub b26: bool,
    #[prost(bool, tag="36")]
    pub b27: bool,
    #[prost(bool, tag="37")]
    pub b28: bool,
    #[prost(bool, tag="38")]
    pub b29: bool,
    #[prost(bool, tag="39")]
    pub b30: bool,
    #[prost(bool, tag="40")]
    pub b31: bool,
    #[prost(bool, tag="41")]
    pub b32: bool,
    #[prost(bool, tag="42")]
    pub b33: bool,
    #[prost(bool, tag="43")]
    pub b34: bool,
    #[prost(bool, tag="44")]
    pub b35: bool,
    #[prost(bool, tag="45")]
    pub b36: bool,
    #[prost(bool, tag="46")]
    pub b37: bool,
    #[prost(bool, tag="47")]
    pub b38: bool,
    #[prost(bool, tag="48")]
    pub b39: bool,
    #[prost(bool, tag="49")]
    pub b40: bool,
    #[prost(bool, tag="50")]
    pub b41: bool,
    #[prost(bool, tag="51")]
    pub b42: bool,
    #[prost(bool, tag="52")]
    pub b43: bool,
    #[prost(bool, tag="53")]
    pub b44: bool,
    #[prost(bool, tag="54")]
    pub b45: bool,
    #[prost(bool, tag="55")]
    pub b46: bool,
    #[prost(bool, tag="56")]
    pub b47: bool,
    #[prost(bool, tag="57")]
    pub b48: bool,
    #[prost(bool, tag="58")]
    pub b49: bool,
    #[prost(uint32, tag="59")]
    pub fid: u32,
    #[prost(int32, tag="60")]
    pub x_min: i32,
    #[prost(int32, tag="61")]
    pub x_centr: i32,
    #[prost(int32, tag="62")]
    pub x_max: i32,
    #[prost(uint32, tag="63")]
    pub x_averaging: u32,
    #[prost(uint32, tag="64")]
    pub x_dead_zone: u32,
    #[prost(int32, tag="65")]
    pub y_min: i32,
    #[prost(int32, tag="66")]
    pub y_centr: i32,
    #[prost(int32, tag="67")]
    pub y_max: i32,
    #[prost(uint32, tag="68")]
    pub y_averaging: u32,
    #[prost(uint32, tag="69")]
    pub y_dead_zone: u32,
    #[prost(int32, tag="70")]
    pub z_min: i32,
    #[prost(int32, tag="71")]
    pub z_centr: i32,
    #[prost(int32, tag="72")]
    pub z_max: i32,
    #[prost(uint32, tag="73")]
    pub z_averaging: u32,
    #[prost(uint32, tag="74")]
    pub z_dead_zone: u32,
    #[prost(int32, tag="75")]
    pub rx_min: i32,
    #[prost(int32, tag="76")]
    pub rx_centr: i32,
    #[prost(int32, tag="77")]
    pub rx_max: i32,
    #[prost(uint32, tag="78")]
    pub rx_averaging: u32,
    #[prost(uint32, tag="79")]
    pub rx_dead_zone: u32,
    #[prost(int32, tag="80")]
    pub ry_min: i32,
    #[prost(int32, tag="81")]
    pub ry_centr: i32,
    #[prost(int32, tag="82")]
    pub ry_max: i32,
    #[prost(uint32, tag="83")]
    pub ry_averaging: u32,
    #[prost(uint32, tag="84")]
    pub ry_dead_zone: u32,
    #[prost(int32, tag="85")]
    pub rz_min: i32,
    #[prost(int32, tag="87")]
    pub rz_max: i32,
    #[prost(uint32, tag="88")]
    pub rz_averaging: u32,
    #[prost(uint32, tag="89")]
    pub rz_dead_zone: u32,
    #[prost(int32, tag="90")]
    pub slider_min: i32,
    #[prost(int32, tag="91")]
    pub slider_max: i32,
    #[prost(uint32, tag="92")]
    pub slider_averaging: u32,
    #[prost(uint32, tag="93")]
    pub slider_dead_zone: u32,
    #[prost(uint32, tag="94")]
    pub encoder_time: u32,
    #[prost(uint32, tag="95")]
    pub led_r: u32,
    #[prost(uint32, tag="96")]
    pub led_g: u32,
    #[prost(uint32, tag="97")]
    pub led_b: u32,
    #[prost(uint32, tag="98")]
    pub id_grib: u32,
    #[prost(uint32, tag="99")]
    pub hatka1_mode: u32,
    #[prost(uint32, tag="100")]
    pub hatka2_mode: u32,
    #[prost(uint32, tag="101")]
    pub hatka3_mode: u32,
    #[prost(uint32, tag="102")]
    pub hatka4_mode: u32,
    #[prost(uint32, tag="103")]
    pub control_byte: u32,
    #[prost(uint32, tag="104")]
    pub gash_button1_min: u32,
    #[prost(uint32, tag="105")]
    pub gash_button1_max: u32,
    #[prost(uint32, tag="106")]
    pub gash_button2_min: u32,
    #[prost(uint32, tag="107")]
    pub gash_button2_max: u32,
    #[prost(uint32, tag="108")]
    pub gash_button3_min: u32,
    #[prost(uint32, tag="109")]
    pub gash_button3_max: u32,
    #[prost(int32, tag="110")]
    pub spi_error_cnt: i32,
    #[prost(uint64, tag="111")]
    pub fbuttons: u64,
    #[prost(int32, tag="112")]
    pub x_axis: i32,
    #[prost(int32, tag="113")]
    pub y_axis: i32,
    #[prost(int32, tag="114")]
    pub z_axis: i32,
    #[prost(int32, tag="115")]
    pub rx_axis: i32,
    #[prost(int32, tag="116")]
    pub ry_axis: i32,
    #[prost(int32, tag="117")]
    pub rz_axis: i32,
    #[prost(int32, tag="118")]
    pub slider_axis: i32,
    #[prost(uint32, tag="119")]
    pub fw_version: u32,
    #[prost(bool, tag="120")]
    pub connected: bool,
    #[prost(string, tag="121")]
    pub base_name: ::prost::alloc::string::String,
    #[prost(string, tag="122")]
    pub side: ::prost::alloc::string::String,
    #[prost(bool, tag="123")]
    pub more_than_two: bool,
    #[prost(bool, tag="124")]
    pub dfu_on: bool,
    #[prost(bool, tag="125")]
    pub fw_update_available: bool,
    #[prost(bool, tag="126")]
    pub inverted_x: bool,
    #[prost(bool, tag="127")]
    pub inverted_y: bool,
    #[prost(bool, tag="128")]
    pub inverted_z: bool,
    #[prost(bool, tag="129")]
    pub inverted_rx: bool,
    #[prost(bool, tag="130")]
    pub inverted_ry: bool,
    #[prost(bool, tag="131")]
    pub inverted_rz: bool,
}
// @@protoc_insertion_point(module)

pub const ID: i32 = 3;