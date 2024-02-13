//
//  Generated code. Do not modify.
//  source: device_info.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ReadValues extends $pb.GeneratedMessage {
  factory ReadValues({
    $core.String? target,
    $core.int? value1,
    $core.int? value2,
    $core.int? value3,
    $core.int? value4,
  }) {
    final $result = create();
    if (target != null) {
      $result.target = target;
    }
    if (value1 != null) {
      $result.value1 = value1;
    }
    if (value2 != null) {
      $result.value2 = value2;
    }
    if (value3 != null) {
      $result.value3 = value3;
    }
    if (value4 != null) {
      $result.value4 = value4;
    }
    return $result;
  }
  ReadValues._() : super();
  factory ReadValues.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReadValues.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReadValues', package: const $pb.PackageName(_omitMessageNames ? '' : 'device_info'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'target')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'value1', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'value2', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'value3', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'value4', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReadValues clone() => ReadValues()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReadValues copyWith(void Function(ReadValues) updates) => super.copyWith((message) => updates(message as ReadValues)) as ReadValues;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReadValues create() => ReadValues._();
  ReadValues createEmptyInstance() => create();
  static $pb.PbList<ReadValues> createRepeated() => $pb.PbList<ReadValues>();
  @$core.pragma('dart2js:noInline')
  static ReadValues getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReadValues>(create);
  static ReadValues? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get target => $_getSZ(0);
  @$pb.TagNumber(1)
  set target($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTarget() => $_has(0);
  @$pb.TagNumber(1)
  void clearTarget() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get value1 => $_getIZ(1);
  @$pb.TagNumber(2)
  set value1($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue1() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue1() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get value2 => $_getIZ(2);
  @$pb.TagNumber(3)
  set value2($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasValue2() => $_has(2);
  @$pb.TagNumber(3)
  void clearValue2() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get value3 => $_getIZ(3);
  @$pb.TagNumber(4)
  set value3($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasValue3() => $_has(3);
  @$pb.TagNumber(4)
  void clearValue3() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get value4 => $_getIZ(4);
  @$pb.TagNumber(5)
  set value4($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasValue4() => $_has(4);
  @$pb.TagNumber(5)
  void clearValue4() => clearField(5);
}

class ReadResponse extends $pb.GeneratedMessage {
  factory ReadResponse({
    $core.int? outputNumbers,
    $core.String? outputString,
  }) {
    final $result = create();
    if (outputNumbers != null) {
      $result.outputNumbers = outputNumbers;
    }
    if (outputString != null) {
      $result.outputString = outputString;
    }
    return $result;
  }
  ReadResponse._() : super();
  factory ReadResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReadResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReadResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'device_info'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'outputNumbers', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'outputString')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReadResponse clone() => ReadResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReadResponse copyWith(void Function(ReadResponse) updates) => super.copyWith((message) => updates(message as ReadResponse)) as ReadResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReadResponse create() => ReadResponse._();
  ReadResponse createEmptyInstance() => create();
  static $pb.PbList<ReadResponse> createRepeated() => $pb.PbList<ReadResponse>();
  @$core.pragma('dart2js:noInline')
  static ReadResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReadResponse>(create);
  static ReadResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get outputNumbers => $_getIZ(0);
  @$pb.TagNumber(1)
  set outputNumbers($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOutputNumbers() => $_has(0);
  @$pb.TagNumber(1)
  void clearOutputNumbers() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get outputString => $_getSZ(1);
  @$pb.TagNumber(2)
  set outputString($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOutputString() => $_has(1);
  @$pb.TagNumber(2)
  void clearOutputString() => clearField(2);
}

/// and slider and everything, depending on string pass the value
class SetValues extends $pb.GeneratedMessage {
  factory SetValues({
    $core.String? target,
    $core.int? value1,
    $core.int? value2,
    $core.int? value3,
    $core.int? value4,
  }) {
    final $result = create();
    if (target != null) {
      $result.target = target;
    }
    if (value1 != null) {
      $result.value1 = value1;
    }
    if (value2 != null) {
      $result.value2 = value2;
    }
    if (value3 != null) {
      $result.value3 = value3;
    }
    if (value4 != null) {
      $result.value4 = value4;
    }
    return $result;
  }
  SetValues._() : super();
  factory SetValues.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetValues.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetValues', package: const $pb.PackageName(_omitMessageNames ? '' : 'device_info'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'target')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'value1', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'value2', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'value3', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'value4', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetValues clone() => SetValues()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetValues copyWith(void Function(SetValues) updates) => super.copyWith((message) => updates(message as SetValues)) as SetValues;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetValues create() => SetValues._();
  SetValues createEmptyInstance() => create();
  static $pb.PbList<SetValues> createRepeated() => $pb.PbList<SetValues>();
  @$core.pragma('dart2js:noInline')
  static SetValues getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetValues>(create);
  static SetValues? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get target => $_getSZ(0);
  @$pb.TagNumber(1)
  set target($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTarget() => $_has(0);
  @$pb.TagNumber(1)
  void clearTarget() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get value1 => $_getIZ(1);
  @$pb.TagNumber(2)
  set value1($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue1() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue1() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get value2 => $_getIZ(2);
  @$pb.TagNumber(3)
  set value2($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasValue2() => $_has(2);
  @$pb.TagNumber(3)
  void clearValue2() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get value3 => $_getIZ(3);
  @$pb.TagNumber(4)
  set value3($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasValue3() => $_has(3);
  @$pb.TagNumber(4)
  void clearValue3() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get value4 => $_getIZ(4);
  @$pb.TagNumber(5)
  set value4($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasValue4() => $_has(4);
  @$pb.TagNumber(5)
  void clearValue4() => clearField(5);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');

const ID = 2;