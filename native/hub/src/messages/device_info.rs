// @generated
// message ReadRequest {
//   repeated int32 input_numbers = 1;
//   string input_string = 2;
// }

#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct ReadValues {
    #[prost(string, tag="1")]
    pub target: ::prost::alloc::string::String,
    #[prost(uint32, tag="2")]
    pub value1: u32,
    #[prost(uint32, tag="3")]
    pub value2: u32,
    #[prost(uint32, tag="4")]
    pub value3: u32,
    #[prost(uint32, tag="5")]
    pub value4: u32,
}
#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct ReadResponse {
    #[prost(int32, tag="1")]
    pub output_numbers: i32,
    #[prost(string, tag="2")]
    pub output_string: ::prost::alloc::string::String,
}
/// and slider and everything, depending on string pass the value
#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct SetValues {
    #[prost(string, tag="1")]
    pub target: ::prost::alloc::string::String,
    #[prost(int32, tag="2")]
    pub value1: i32,
    #[prost(int32, tag="3")]
    pub value2: i32,
    #[prost(int32, tag="4")]
    pub value3: i32,
    #[prost(int32, tag="5")]
    pub value4: i32,
}
// @@protoc_insertion_point(module)

pub const ID: i32 = 2;