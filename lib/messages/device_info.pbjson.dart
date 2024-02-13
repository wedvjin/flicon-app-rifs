//
//  Generated code. Do not modify.
//  source: device_info.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use readValuesDescriptor instead')
const ReadValues$json = {
  '1': 'ReadValues',
  '2': [
    {'1': 'target', '3': 1, '4': 1, '5': 9, '10': 'target'},
    {'1': 'value1', '3': 2, '4': 1, '5': 13, '10': 'value1'},
    {'1': 'value2', '3': 3, '4': 1, '5': 13, '10': 'value2'},
    {'1': 'value3', '3': 4, '4': 1, '5': 13, '10': 'value3'},
    {'1': 'value4', '3': 5, '4': 1, '5': 13, '10': 'value4'},
  ],
};

/// Descriptor for `ReadValues`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readValuesDescriptor = $convert.base64Decode(
    'CgpSZWFkVmFsdWVzEhYKBnRhcmdldBgBIAEoCVIGdGFyZ2V0EhYKBnZhbHVlMRgCIAEoDVIGdm'
    'FsdWUxEhYKBnZhbHVlMhgDIAEoDVIGdmFsdWUyEhYKBnZhbHVlMxgEIAEoDVIGdmFsdWUzEhYK'
    'BnZhbHVlNBgFIAEoDVIGdmFsdWU0');

@$core.Deprecated('Use readResponseDescriptor instead')
const ReadResponse$json = {
  '1': 'ReadResponse',
  '2': [
    {'1': 'output_numbers', '3': 1, '4': 1, '5': 5, '10': 'outputNumbers'},
    {'1': 'output_string', '3': 2, '4': 1, '5': 9, '10': 'outputString'},
  ],
};

/// Descriptor for `ReadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readResponseDescriptor = $convert.base64Decode(
    'CgxSZWFkUmVzcG9uc2USJQoOb3V0cHV0X251bWJlcnMYASABKAVSDW91dHB1dE51bWJlcnMSIw'
    'oNb3V0cHV0X3N0cmluZxgCIAEoCVIMb3V0cHV0U3RyaW5n');

@$core.Deprecated('Use setValuesDescriptor instead')
const SetValues$json = {
  '1': 'SetValues',
  '2': [
    {'1': 'target', '3': 1, '4': 1, '5': 9, '10': 'target'},
    {'1': 'value1', '3': 2, '4': 1, '5': 5, '10': 'value1'},
    {'1': 'value2', '3': 3, '4': 1, '5': 5, '10': 'value2'},
    {'1': 'value3', '3': 4, '4': 1, '5': 5, '10': 'value3'},
    {'1': 'value4', '3': 5, '4': 1, '5': 5, '10': 'value4'},
  ],
};

/// Descriptor for `SetValues`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setValuesDescriptor = $convert.base64Decode(
    'CglTZXRWYWx1ZXMSFgoGdGFyZ2V0GAEgASgJUgZ0YXJnZXQSFgoGdmFsdWUxGAIgASgFUgZ2YW'
    'x1ZTESFgoGdmFsdWUyGAMgASgFUgZ2YWx1ZTISFgoGdmFsdWUzGAQgASgFUgZ2YWx1ZTMSFgoG'
    'dmFsdWU0GAUgASgFUgZ2YWx1ZTQ=');

