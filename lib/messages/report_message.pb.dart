//
//  Generated code. Do not modify.
//  source: report_message.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class ReportMessage extends $pb.GeneratedMessage {
  factory ReportMessage({
    $core.int? id,
    $fixnum.Int64? buttons,
    $core.int? x,
    $core.int? y,
    $core.int? z,
    $core.int? rx,
    $core.int? ry,
    $core.int? rz,
    $core.int? slider,
    $core.bool? b1,
    $core.bool? b2,
    $core.bool? b3,
    $core.bool? b4,
    $core.bool? b5,
    $core.bool? b6,
    $core.bool? b7,
    $core.bool? b8,
    $core.bool? b9,
    $core.bool? b10,
    $core.bool? b11,
    $core.bool? b12,
    $core.bool? b13,
    $core.bool? b14,
    $core.bool? b15,
    $core.bool? b16,
    $core.bool? b17,
    $core.bool? b18,
    $core.bool? b19,
    $core.bool? b20,
    $core.bool? b21,
    $core.bool? b22,
    $core.bool? b23,
    $core.bool? b24,
    $core.bool? b25,
    $core.bool? b26,
    $core.bool? b27,
    $core.bool? b28,
    $core.bool? b29,
    $core.bool? b30,
    $core.bool? b31,
    $core.bool? b32,
    $core.bool? b33,
    $core.bool? b34,
    $core.bool? b35,
    $core.bool? b36,
    $core.bool? b37,
    $core.bool? b38,
    $core.bool? b39,
    $core.bool? b40,
    $core.bool? b41,
    $core.bool? b42,
    $core.bool? b43,
    $core.bool? b44,
    $core.bool? b45,
    $core.bool? b46,
    $core.bool? b47,
    $core.bool? b48,
    $core.bool? b49,
    $core.int? fid,
    $core.int? xMin,
    $core.int? xCentr,
    $core.int? xMax,
    $core.int? xAveraging,
    $core.int? xDeadZone,
    $core.int? yMin,
    $core.int? yCentr,
    $core.int? yMax,
    $core.int? yAveraging,
    $core.int? yDeadZone,
    $core.int? zMin,
    $core.int? zCentr,
    $core.int? zMax,
    $core.int? zAveraging,
    $core.int? zDeadZone,
    $core.int? rxMin,
    $core.int? rxCentr,
    $core.int? rxMax,
    $core.int? rxAveraging,
    $core.int? rxDeadZone,
    $core.int? ryMin,
    $core.int? ryCentr,
    $core.int? ryMax,
    $core.int? ryAveraging,
    $core.int? ryDeadZone,
    $core.int? rzMin,
    $core.int? rzMax,
    $core.int? rzAveraging,
    $core.int? rzDeadZone,
    $core.int? sliderMin,
    $core.int? sliderMax,
    $core.int? sliderAveraging,
    $core.int? sliderDeadZone,
    $core.int? encoderTime,
    $core.int? ledR,
    $core.int? ledG,
    $core.int? ledB,
    $core.int? idGrib,
    $core.int? hatka1Mode,
    $core.int? hatka2Mode,
    $core.int? hatka3Mode,
    $core.int? hatka4Mode,
    $core.int? controlByte,
    $core.int? gashButton1Min,
    $core.int? gashButton1Max,
    $core.int? gashButton2Min,
    $core.int? gashButton2Max,
    $core.int? gashButton3Min,
    $core.int? gashButton3Max,
    $core.int? spiErrorCnt,
    $fixnum.Int64? fbuttons,
    $core.int? xAxis,
    $core.int? yAxis,
    $core.int? zAxis,
    $core.int? rxAxis,
    $core.int? ryAxis,
    $core.int? rzAxis,
    $core.int? sliderAxis,
    $core.int? fwVersion,
    $core.bool? connected,
    $core.String? baseName,
    $core.String? side,
    $core.bool? moreThanTwo,
    $core.bool? dfuOn,
    $core.bool? fwUpdateAvailable,
    $core.bool? invertedX,
    $core.bool? invertedY,
    $core.bool? invertedZ,
    $core.bool? invertedRx,
    $core.bool? invertedRy,
    $core.bool? invertedRz,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (buttons != null) {
      $result.buttons = buttons;
    }
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    if (z != null) {
      $result.z = z;
    }
    if (rx != null) {
      $result.rx = rx;
    }
    if (ry != null) {
      $result.ry = ry;
    }
    if (rz != null) {
      $result.rz = rz;
    }
    if (slider != null) {
      $result.slider = slider;
    }
    if (b1 != null) {
      $result.b1 = b1;
    }
    if (b2 != null) {
      $result.b2 = b2;
    }
    if (b3 != null) {
      $result.b3 = b3;
    }
    if (b4 != null) {
      $result.b4 = b4;
    }
    if (b5 != null) {
      $result.b5 = b5;
    }
    if (b6 != null) {
      $result.b6 = b6;
    }
    if (b7 != null) {
      $result.b7 = b7;
    }
    if (b8 != null) {
      $result.b8 = b8;
    }
    if (b9 != null) {
      $result.b9 = b9;
    }
    if (b10 != null) {
      $result.b10 = b10;
    }
    if (b11 != null) {
      $result.b11 = b11;
    }
    if (b12 != null) {
      $result.b12 = b12;
    }
    if (b13 != null) {
      $result.b13 = b13;
    }
    if (b14 != null) {
      $result.b14 = b14;
    }
    if (b15 != null) {
      $result.b15 = b15;
    }
    if (b16 != null) {
      $result.b16 = b16;
    }
    if (b17 != null) {
      $result.b17 = b17;
    }
    if (b18 != null) {
      $result.b18 = b18;
    }
    if (b19 != null) {
      $result.b19 = b19;
    }
    if (b20 != null) {
      $result.b20 = b20;
    }
    if (b21 != null) {
      $result.b21 = b21;
    }
    if (b22 != null) {
      $result.b22 = b22;
    }
    if (b23 != null) {
      $result.b23 = b23;
    }
    if (b24 != null) {
      $result.b24 = b24;
    }
    if (b25 != null) {
      $result.b25 = b25;
    }
    if (b26 != null) {
      $result.b26 = b26;
    }
    if (b27 != null) {
      $result.b27 = b27;
    }
    if (b28 != null) {
      $result.b28 = b28;
    }
    if (b29 != null) {
      $result.b29 = b29;
    }
    if (b30 != null) {
      $result.b30 = b30;
    }
    if (b31 != null) {
      $result.b31 = b31;
    }
    if (b32 != null) {
      $result.b32 = b32;
    }
    if (b33 != null) {
      $result.b33 = b33;
    }
    if (b34 != null) {
      $result.b34 = b34;
    }
    if (b35 != null) {
      $result.b35 = b35;
    }
    if (b36 != null) {
      $result.b36 = b36;
    }
    if (b37 != null) {
      $result.b37 = b37;
    }
    if (b38 != null) {
      $result.b38 = b38;
    }
    if (b39 != null) {
      $result.b39 = b39;
    }
    if (b40 != null) {
      $result.b40 = b40;
    }
    if (b41 != null) {
      $result.b41 = b41;
    }
    if (b42 != null) {
      $result.b42 = b42;
    }
    if (b43 != null) {
      $result.b43 = b43;
    }
    if (b44 != null) {
      $result.b44 = b44;
    }
    if (b45 != null) {
      $result.b45 = b45;
    }
    if (b46 != null) {
      $result.b46 = b46;
    }
    if (b47 != null) {
      $result.b47 = b47;
    }
    if (b48 != null) {
      $result.b48 = b48;
    }
    if (b49 != null) {
      $result.b49 = b49;
    }
    if (fid != null) {
      $result.fid = fid;
    }
    if (xMin != null) {
      $result.xMin = xMin;
    }
    if (xCentr != null) {
      $result.xCentr = xCentr;
    }
    if (xMax != null) {
      $result.xMax = xMax;
    }
    if (xAveraging != null) {
      $result.xAveraging = xAveraging;
    }
    if (xDeadZone != null) {
      $result.xDeadZone = xDeadZone;
    }
    if (yMin != null) {
      $result.yMin = yMin;
    }
    if (yCentr != null) {
      $result.yCentr = yCentr;
    }
    if (yMax != null) {
      $result.yMax = yMax;
    }
    if (yAveraging != null) {
      $result.yAveraging = yAveraging;
    }
    if (yDeadZone != null) {
      $result.yDeadZone = yDeadZone;
    }
    if (zMin != null) {
      $result.zMin = zMin;
    }
    if (zCentr != null) {
      $result.zCentr = zCentr;
    }
    if (zMax != null) {
      $result.zMax = zMax;
    }
    if (zAveraging != null) {
      $result.zAveraging = zAveraging;
    }
    if (zDeadZone != null) {
      $result.zDeadZone = zDeadZone;
    }
    if (rxMin != null) {
      $result.rxMin = rxMin;
    }
    if (rxCentr != null) {
      $result.rxCentr = rxCentr;
    }
    if (rxMax != null) {
      $result.rxMax = rxMax;
    }
    if (rxAveraging != null) {
      $result.rxAveraging = rxAveraging;
    }
    if (rxDeadZone != null) {
      $result.rxDeadZone = rxDeadZone;
    }
    if (ryMin != null) {
      $result.ryMin = ryMin;
    }
    if (ryCentr != null) {
      $result.ryCentr = ryCentr;
    }
    if (ryMax != null) {
      $result.ryMax = ryMax;
    }
    if (ryAveraging != null) {
      $result.ryAveraging = ryAveraging;
    }
    if (ryDeadZone != null) {
      $result.ryDeadZone = ryDeadZone;
    }
    if (rzMin != null) {
      $result.rzMin = rzMin;
    }
    if (rzMax != null) {
      $result.rzMax = rzMax;
    }
    if (rzAveraging != null) {
      $result.rzAveraging = rzAveraging;
    }
    if (rzDeadZone != null) {
      $result.rzDeadZone = rzDeadZone;
    }
    if (sliderMin != null) {
      $result.sliderMin = sliderMin;
    }
    if (sliderMax != null) {
      $result.sliderMax = sliderMax;
    }
    if (sliderAveraging != null) {
      $result.sliderAveraging = sliderAveraging;
    }
    if (sliderDeadZone != null) {
      $result.sliderDeadZone = sliderDeadZone;
    }
    if (encoderTime != null) {
      $result.encoderTime = encoderTime;
    }
    if (ledR != null) {
      $result.ledR = ledR;
    }
    if (ledG != null) {
      $result.ledG = ledG;
    }
    if (ledB != null) {
      $result.ledB = ledB;
    }
    if (idGrib != null) {
      $result.idGrib = idGrib;
    }
    if (hatka1Mode != null) {
      $result.hatka1Mode = hatka1Mode;
    }
    if (hatka2Mode != null) {
      $result.hatka2Mode = hatka2Mode;
    }
    if (hatka3Mode != null) {
      $result.hatka3Mode = hatka3Mode;
    }
    if (hatka4Mode != null) {
      $result.hatka4Mode = hatka4Mode;
    }
    if (controlByte != null) {
      $result.controlByte = controlByte;
    }
    if (gashButton1Min != null) {
      $result.gashButton1Min = gashButton1Min;
    }
    if (gashButton1Max != null) {
      $result.gashButton1Max = gashButton1Max;
    }
    if (gashButton2Min != null) {
      $result.gashButton2Min = gashButton2Min;
    }
    if (gashButton2Max != null) {
      $result.gashButton2Max = gashButton2Max;
    }
    if (gashButton3Min != null) {
      $result.gashButton3Min = gashButton3Min;
    }
    if (gashButton3Max != null) {
      $result.gashButton3Max = gashButton3Max;
    }
    if (spiErrorCnt != null) {
      $result.spiErrorCnt = spiErrorCnt;
    }
    if (fbuttons != null) {
      $result.fbuttons = fbuttons;
    }
    if (xAxis != null) {
      $result.xAxis = xAxis;
    }
    if (yAxis != null) {
      $result.yAxis = yAxis;
    }
    if (zAxis != null) {
      $result.zAxis = zAxis;
    }
    if (rxAxis != null) {
      $result.rxAxis = rxAxis;
    }
    if (ryAxis != null) {
      $result.ryAxis = ryAxis;
    }
    if (rzAxis != null) {
      $result.rzAxis = rzAxis;
    }
    if (sliderAxis != null) {
      $result.sliderAxis = sliderAxis;
    }
    if (fwVersion != null) {
      $result.fwVersion = fwVersion;
    }
    if (connected != null) {
      $result.connected = connected;
    }
    if (baseName != null) {
      $result.baseName = baseName;
    }
    if (side != null) {
      $result.side = side;
    }
    if (moreThanTwo != null) {
      $result.moreThanTwo = moreThanTwo;
    }
    if (dfuOn != null) {
      $result.dfuOn = dfuOn;
    }
    if (fwUpdateAvailable != null) {
      $result.fwUpdateAvailable = fwUpdateAvailable;
    }
    if (invertedX != null) {
      $result.invertedX = invertedX;
    }
    if (invertedY != null) {
      $result.invertedY = invertedY;
    }
    if (invertedZ != null) {
      $result.invertedZ = invertedZ;
    }
    if (invertedRx != null) {
      $result.invertedRx = invertedRx;
    }
    if (invertedRy != null) {
      $result.invertedRy = invertedRy;
    }
    if (invertedRz != null) {
      $result.invertedRz = invertedRz;
    }
    return $result;
  }
  ReportMessage._() : super();
  factory ReportMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReportMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReportMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'report_message'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'buttons', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'z', $pb.PbFieldType.OU3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'rx', $pb.PbFieldType.OU3)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'ry', $pb.PbFieldType.OU3)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'rz', $pb.PbFieldType.OU3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'slider', $pb.PbFieldType.OU3)
    ..aOB(10, _omitFieldNames ? '' : 'b1')
    ..aOB(11, _omitFieldNames ? '' : 'b2')
    ..aOB(12, _omitFieldNames ? '' : 'b3')
    ..aOB(13, _omitFieldNames ? '' : 'b4')
    ..aOB(14, _omitFieldNames ? '' : 'b5')
    ..aOB(15, _omitFieldNames ? '' : 'b6')
    ..aOB(16, _omitFieldNames ? '' : 'b7')
    ..aOB(17, _omitFieldNames ? '' : 'b8')
    ..aOB(18, _omitFieldNames ? '' : 'b9')
    ..aOB(19, _omitFieldNames ? '' : 'b10')
    ..aOB(20, _omitFieldNames ? '' : 'b11')
    ..aOB(21, _omitFieldNames ? '' : 'b12')
    ..aOB(22, _omitFieldNames ? '' : 'b13')
    ..aOB(23, _omitFieldNames ? '' : 'b14')
    ..aOB(24, _omitFieldNames ? '' : 'b15')
    ..aOB(25, _omitFieldNames ? '' : 'b16')
    ..aOB(26, _omitFieldNames ? '' : 'b17')
    ..aOB(27, _omitFieldNames ? '' : 'b18')
    ..aOB(28, _omitFieldNames ? '' : 'b19')
    ..aOB(29, _omitFieldNames ? '' : 'b20')
    ..aOB(30, _omitFieldNames ? '' : 'b21')
    ..aOB(31, _omitFieldNames ? '' : 'b22')
    ..aOB(32, _omitFieldNames ? '' : 'b23')
    ..aOB(33, _omitFieldNames ? '' : 'b24')
    ..aOB(34, _omitFieldNames ? '' : 'b25')
    ..aOB(35, _omitFieldNames ? '' : 'b26')
    ..aOB(36, _omitFieldNames ? '' : 'b27')
    ..aOB(37, _omitFieldNames ? '' : 'b28')
    ..aOB(38, _omitFieldNames ? '' : 'b29')
    ..aOB(39, _omitFieldNames ? '' : 'b30')
    ..aOB(40, _omitFieldNames ? '' : 'b31')
    ..aOB(41, _omitFieldNames ? '' : 'b32')
    ..aOB(42, _omitFieldNames ? '' : 'b33')
    ..aOB(43, _omitFieldNames ? '' : 'b34')
    ..aOB(44, _omitFieldNames ? '' : 'b35')
    ..aOB(45, _omitFieldNames ? '' : 'b36')
    ..aOB(46, _omitFieldNames ? '' : 'b37')
    ..aOB(47, _omitFieldNames ? '' : 'b38')
    ..aOB(48, _omitFieldNames ? '' : 'b39')
    ..aOB(49, _omitFieldNames ? '' : 'b40')
    ..aOB(50, _omitFieldNames ? '' : 'b41')
    ..aOB(51, _omitFieldNames ? '' : 'b42')
    ..aOB(52, _omitFieldNames ? '' : 'b43')
    ..aOB(53, _omitFieldNames ? '' : 'b44')
    ..aOB(54, _omitFieldNames ? '' : 'b45')
    ..aOB(55, _omitFieldNames ? '' : 'b46')
    ..aOB(56, _omitFieldNames ? '' : 'b47')
    ..aOB(57, _omitFieldNames ? '' : 'b48')
    ..aOB(58, _omitFieldNames ? '' : 'b49')
    ..a<$core.int>(59, _omitFieldNames ? '' : 'fid', $pb.PbFieldType.OU3)
    ..a<$core.int>(60, _omitFieldNames ? '' : 'xMin', $pb.PbFieldType.O3)
    ..a<$core.int>(61, _omitFieldNames ? '' : 'xCentr', $pb.PbFieldType.O3)
    ..a<$core.int>(62, _omitFieldNames ? '' : 'xMax', $pb.PbFieldType.O3)
    ..a<$core.int>(63, _omitFieldNames ? '' : 'xAveraging', $pb.PbFieldType.OU3)
    ..a<$core.int>(64, _omitFieldNames ? '' : 'xDeadZone', $pb.PbFieldType.OU3)
    ..a<$core.int>(65, _omitFieldNames ? '' : 'yMin', $pb.PbFieldType.O3)
    ..a<$core.int>(66, _omitFieldNames ? '' : 'yCentr', $pb.PbFieldType.O3)
    ..a<$core.int>(67, _omitFieldNames ? '' : 'yMax', $pb.PbFieldType.O3)
    ..a<$core.int>(68, _omitFieldNames ? '' : 'yAveraging', $pb.PbFieldType.OU3)
    ..a<$core.int>(69, _omitFieldNames ? '' : 'yDeadZone', $pb.PbFieldType.OU3)
    ..a<$core.int>(70, _omitFieldNames ? '' : 'zMin', $pb.PbFieldType.O3)
    ..a<$core.int>(71, _omitFieldNames ? '' : 'zCentr', $pb.PbFieldType.O3)
    ..a<$core.int>(72, _omitFieldNames ? '' : 'zMax', $pb.PbFieldType.O3)
    ..a<$core.int>(73, _omitFieldNames ? '' : 'zAveraging', $pb.PbFieldType.OU3)
    ..a<$core.int>(74, _omitFieldNames ? '' : 'zDeadZone', $pb.PbFieldType.OU3)
    ..a<$core.int>(75, _omitFieldNames ? '' : 'rxMin', $pb.PbFieldType.O3)
    ..a<$core.int>(76, _omitFieldNames ? '' : 'rxCentr', $pb.PbFieldType.O3)
    ..a<$core.int>(77, _omitFieldNames ? '' : 'rxMax', $pb.PbFieldType.O3)
    ..a<$core.int>(78, _omitFieldNames ? '' : 'rxAveraging', $pb.PbFieldType.OU3)
    ..a<$core.int>(79, _omitFieldNames ? '' : 'rxDeadZone', $pb.PbFieldType.OU3)
    ..a<$core.int>(80, _omitFieldNames ? '' : 'ryMin', $pb.PbFieldType.O3)
    ..a<$core.int>(81, _omitFieldNames ? '' : 'ryCentr', $pb.PbFieldType.O3)
    ..a<$core.int>(82, _omitFieldNames ? '' : 'ryMax', $pb.PbFieldType.O3)
    ..a<$core.int>(83, _omitFieldNames ? '' : 'ryAveraging', $pb.PbFieldType.OU3)
    ..a<$core.int>(84, _omitFieldNames ? '' : 'ryDeadZone', $pb.PbFieldType.OU3)
    ..a<$core.int>(85, _omitFieldNames ? '' : 'rzMin', $pb.PbFieldType.O3)
    ..a<$core.int>(87, _omitFieldNames ? '' : 'rzMax', $pb.PbFieldType.O3)
    ..a<$core.int>(88, _omitFieldNames ? '' : 'rzAveraging', $pb.PbFieldType.OU3)
    ..a<$core.int>(89, _omitFieldNames ? '' : 'rzDeadZone', $pb.PbFieldType.OU3)
    ..a<$core.int>(90, _omitFieldNames ? '' : 'sliderMin', $pb.PbFieldType.O3)
    ..a<$core.int>(91, _omitFieldNames ? '' : 'sliderMax', $pb.PbFieldType.O3)
    ..a<$core.int>(92, _omitFieldNames ? '' : 'sliderAveraging', $pb.PbFieldType.OU3)
    ..a<$core.int>(93, _omitFieldNames ? '' : 'sliderDeadZone', $pb.PbFieldType.OU3)
    ..a<$core.int>(94, _omitFieldNames ? '' : 'encoderTime', $pb.PbFieldType.OU3)
    ..a<$core.int>(95, _omitFieldNames ? '' : 'ledR', $pb.PbFieldType.OU3)
    ..a<$core.int>(96, _omitFieldNames ? '' : 'ledG', $pb.PbFieldType.OU3)
    ..a<$core.int>(97, _omitFieldNames ? '' : 'ledB', $pb.PbFieldType.OU3)
    ..a<$core.int>(98, _omitFieldNames ? '' : 'idGrib', $pb.PbFieldType.OU3)
    ..a<$core.int>(99, _omitFieldNames ? '' : 'hatka1Mode', $pb.PbFieldType.OU3)
    ..a<$core.int>(100, _omitFieldNames ? '' : 'hatka2Mode', $pb.PbFieldType.OU3)
    ..a<$core.int>(101, _omitFieldNames ? '' : 'hatka3Mode', $pb.PbFieldType.OU3)
    ..a<$core.int>(102, _omitFieldNames ? '' : 'hatka4Mode', $pb.PbFieldType.OU3)
    ..a<$core.int>(103, _omitFieldNames ? '' : 'controlByte', $pb.PbFieldType.OU3)
    ..a<$core.int>(104, _omitFieldNames ? '' : 'gashButton1Min', $pb.PbFieldType.OU3)
    ..a<$core.int>(105, _omitFieldNames ? '' : 'gashButton1Max', $pb.PbFieldType.OU3)
    ..a<$core.int>(106, _omitFieldNames ? '' : 'gashButton2Min', $pb.PbFieldType.OU3)
    ..a<$core.int>(107, _omitFieldNames ? '' : 'gashButton2Max', $pb.PbFieldType.OU3)
    ..a<$core.int>(108, _omitFieldNames ? '' : 'gashButton3Min', $pb.PbFieldType.OU3)
    ..a<$core.int>(109, _omitFieldNames ? '' : 'gashButton3Max', $pb.PbFieldType.OU3)
    ..a<$core.int>(110, _omitFieldNames ? '' : 'spiErrorCnt', $pb.PbFieldType.O3)
    ..a<$fixnum.Int64>(111, _omitFieldNames ? '' : 'fbuttons', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(112, _omitFieldNames ? '' : 'xAxis', $pb.PbFieldType.O3)
    ..a<$core.int>(113, _omitFieldNames ? '' : 'yAxis', $pb.PbFieldType.O3)
    ..a<$core.int>(114, _omitFieldNames ? '' : 'zAxis', $pb.PbFieldType.O3)
    ..a<$core.int>(115, _omitFieldNames ? '' : 'rxAxis', $pb.PbFieldType.O3)
    ..a<$core.int>(116, _omitFieldNames ? '' : 'ryAxis', $pb.PbFieldType.O3)
    ..a<$core.int>(117, _omitFieldNames ? '' : 'rzAxis', $pb.PbFieldType.O3)
    ..a<$core.int>(118, _omitFieldNames ? '' : 'sliderAxis', $pb.PbFieldType.O3)
    ..a<$core.int>(119, _omitFieldNames ? '' : 'fwVersion', $pb.PbFieldType.OU3)
    ..aOB(120, _omitFieldNames ? '' : 'connected')
    ..aOS(121, _omitFieldNames ? '' : 'baseName')
    ..aOS(122, _omitFieldNames ? '' : 'side')
    ..aOB(123, _omitFieldNames ? '' : 'moreThanTwo')
    ..aOB(124, _omitFieldNames ? '' : 'dfuOn')
    ..aOB(125, _omitFieldNames ? '' : 'fwUpdateAvailable')
    ..aOB(126, _omitFieldNames ? '' : 'invertedX')
    ..aOB(127, _omitFieldNames ? '' : 'invertedY')
    ..aOB(128, _omitFieldNames ? '' : 'invertedZ')
    ..aOB(129, _omitFieldNames ? '' : 'invertedRx')
    ..aOB(130, _omitFieldNames ? '' : 'invertedRy')
    ..aOB(131, _omitFieldNames ? '' : 'invertedRz')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReportMessage clone() => ReportMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReportMessage copyWith(void Function(ReportMessage) updates) => super.copyWith((message) => updates(message as ReportMessage)) as ReportMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReportMessage create() => ReportMessage._();
  ReportMessage createEmptyInstance() => create();
  static $pb.PbList<ReportMessage> createRepeated() => $pb.PbList<ReportMessage>();
  @$core.pragma('dart2js:noInline')
  static ReportMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReportMessage>(create);
  static ReportMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get buttons => $_getI64(1);
  @$pb.TagNumber(2)
  set buttons($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasButtons() => $_has(1);
  @$pb.TagNumber(2)
  void clearButtons() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get x => $_getIZ(2);
  @$pb.TagNumber(3)
  set x($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasX() => $_has(2);
  @$pb.TagNumber(3)
  void clearX() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get y => $_getIZ(3);
  @$pb.TagNumber(4)
  set y($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasY() => $_has(3);
  @$pb.TagNumber(4)
  void clearY() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get z => $_getIZ(4);
  @$pb.TagNumber(5)
  set z($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasZ() => $_has(4);
  @$pb.TagNumber(5)
  void clearZ() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get rx => $_getIZ(5);
  @$pb.TagNumber(6)
  set rx($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRx() => $_has(5);
  @$pb.TagNumber(6)
  void clearRx() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get ry => $_getIZ(6);
  @$pb.TagNumber(7)
  set ry($core.int v) { $_setUnsignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRy() => $_has(6);
  @$pb.TagNumber(7)
  void clearRy() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get rz => $_getIZ(7);
  @$pb.TagNumber(8)
  set rz($core.int v) { $_setUnsignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRz() => $_has(7);
  @$pb.TagNumber(8)
  void clearRz() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get slider => $_getIZ(8);
  @$pb.TagNumber(9)
  set slider($core.int v) { $_setUnsignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasSlider() => $_has(8);
  @$pb.TagNumber(9)
  void clearSlider() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get b1 => $_getBF(9);
  @$pb.TagNumber(10)
  set b1($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasB1() => $_has(9);
  @$pb.TagNumber(10)
  void clearB1() => clearField(10);

  @$pb.TagNumber(11)
  $core.bool get b2 => $_getBF(10);
  @$pb.TagNumber(11)
  set b2($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasB2() => $_has(10);
  @$pb.TagNumber(11)
  void clearB2() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get b3 => $_getBF(11);
  @$pb.TagNumber(12)
  set b3($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasB3() => $_has(11);
  @$pb.TagNumber(12)
  void clearB3() => clearField(12);

  @$pb.TagNumber(13)
  $core.bool get b4 => $_getBF(12);
  @$pb.TagNumber(13)
  set b4($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasB4() => $_has(12);
  @$pb.TagNumber(13)
  void clearB4() => clearField(13);

  @$pb.TagNumber(14)
  $core.bool get b5 => $_getBF(13);
  @$pb.TagNumber(14)
  set b5($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasB5() => $_has(13);
  @$pb.TagNumber(14)
  void clearB5() => clearField(14);

  @$pb.TagNumber(15)
  $core.bool get b6 => $_getBF(14);
  @$pb.TagNumber(15)
  set b6($core.bool v) { $_setBool(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasB6() => $_has(14);
  @$pb.TagNumber(15)
  void clearB6() => clearField(15);

  @$pb.TagNumber(16)
  $core.bool get b7 => $_getBF(15);
  @$pb.TagNumber(16)
  set b7($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasB7() => $_has(15);
  @$pb.TagNumber(16)
  void clearB7() => clearField(16);

  @$pb.TagNumber(17)
  $core.bool get b8 => $_getBF(16);
  @$pb.TagNumber(17)
  set b8($core.bool v) { $_setBool(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasB8() => $_has(16);
  @$pb.TagNumber(17)
  void clearB8() => clearField(17);

  @$pb.TagNumber(18)
  $core.bool get b9 => $_getBF(17);
  @$pb.TagNumber(18)
  set b9($core.bool v) { $_setBool(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasB9() => $_has(17);
  @$pb.TagNumber(18)
  void clearB9() => clearField(18);

  @$pb.TagNumber(19)
  $core.bool get b10 => $_getBF(18);
  @$pb.TagNumber(19)
  set b10($core.bool v) { $_setBool(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasB10() => $_has(18);
  @$pb.TagNumber(19)
  void clearB10() => clearField(19);

  @$pb.TagNumber(20)
  $core.bool get b11 => $_getBF(19);
  @$pb.TagNumber(20)
  set b11($core.bool v) { $_setBool(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasB11() => $_has(19);
  @$pb.TagNumber(20)
  void clearB11() => clearField(20);

  @$pb.TagNumber(21)
  $core.bool get b12 => $_getBF(20);
  @$pb.TagNumber(21)
  set b12($core.bool v) { $_setBool(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasB12() => $_has(20);
  @$pb.TagNumber(21)
  void clearB12() => clearField(21);

  @$pb.TagNumber(22)
  $core.bool get b13 => $_getBF(21);
  @$pb.TagNumber(22)
  set b13($core.bool v) { $_setBool(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasB13() => $_has(21);
  @$pb.TagNumber(22)
  void clearB13() => clearField(22);

  @$pb.TagNumber(23)
  $core.bool get b14 => $_getBF(22);
  @$pb.TagNumber(23)
  set b14($core.bool v) { $_setBool(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasB14() => $_has(22);
  @$pb.TagNumber(23)
  void clearB14() => clearField(23);

  @$pb.TagNumber(24)
  $core.bool get b15 => $_getBF(23);
  @$pb.TagNumber(24)
  set b15($core.bool v) { $_setBool(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasB15() => $_has(23);
  @$pb.TagNumber(24)
  void clearB15() => clearField(24);

  @$pb.TagNumber(25)
  $core.bool get b16 => $_getBF(24);
  @$pb.TagNumber(25)
  set b16($core.bool v) { $_setBool(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasB16() => $_has(24);
  @$pb.TagNumber(25)
  void clearB16() => clearField(25);

  @$pb.TagNumber(26)
  $core.bool get b17 => $_getBF(25);
  @$pb.TagNumber(26)
  set b17($core.bool v) { $_setBool(25, v); }
  @$pb.TagNumber(26)
  $core.bool hasB17() => $_has(25);
  @$pb.TagNumber(26)
  void clearB17() => clearField(26);

  @$pb.TagNumber(27)
  $core.bool get b18 => $_getBF(26);
  @$pb.TagNumber(27)
  set b18($core.bool v) { $_setBool(26, v); }
  @$pb.TagNumber(27)
  $core.bool hasB18() => $_has(26);
  @$pb.TagNumber(27)
  void clearB18() => clearField(27);

  @$pb.TagNumber(28)
  $core.bool get b19 => $_getBF(27);
  @$pb.TagNumber(28)
  set b19($core.bool v) { $_setBool(27, v); }
  @$pb.TagNumber(28)
  $core.bool hasB19() => $_has(27);
  @$pb.TagNumber(28)
  void clearB19() => clearField(28);

  @$pb.TagNumber(29)
  $core.bool get b20 => $_getBF(28);
  @$pb.TagNumber(29)
  set b20($core.bool v) { $_setBool(28, v); }
  @$pb.TagNumber(29)
  $core.bool hasB20() => $_has(28);
  @$pb.TagNumber(29)
  void clearB20() => clearField(29);

  @$pb.TagNumber(30)
  $core.bool get b21 => $_getBF(29);
  @$pb.TagNumber(30)
  set b21($core.bool v) { $_setBool(29, v); }
  @$pb.TagNumber(30)
  $core.bool hasB21() => $_has(29);
  @$pb.TagNumber(30)
  void clearB21() => clearField(30);

  @$pb.TagNumber(31)
  $core.bool get b22 => $_getBF(30);
  @$pb.TagNumber(31)
  set b22($core.bool v) { $_setBool(30, v); }
  @$pb.TagNumber(31)
  $core.bool hasB22() => $_has(30);
  @$pb.TagNumber(31)
  void clearB22() => clearField(31);

  @$pb.TagNumber(32)
  $core.bool get b23 => $_getBF(31);
  @$pb.TagNumber(32)
  set b23($core.bool v) { $_setBool(31, v); }
  @$pb.TagNumber(32)
  $core.bool hasB23() => $_has(31);
  @$pb.TagNumber(32)
  void clearB23() => clearField(32);

  @$pb.TagNumber(33)
  $core.bool get b24 => $_getBF(32);
  @$pb.TagNumber(33)
  set b24($core.bool v) { $_setBool(32, v); }
  @$pb.TagNumber(33)
  $core.bool hasB24() => $_has(32);
  @$pb.TagNumber(33)
  void clearB24() => clearField(33);

  @$pb.TagNumber(34)
  $core.bool get b25 => $_getBF(33);
  @$pb.TagNumber(34)
  set b25($core.bool v) { $_setBool(33, v); }
  @$pb.TagNumber(34)
  $core.bool hasB25() => $_has(33);
  @$pb.TagNumber(34)
  void clearB25() => clearField(34);

  @$pb.TagNumber(35)
  $core.bool get b26 => $_getBF(34);
  @$pb.TagNumber(35)
  set b26($core.bool v) { $_setBool(34, v); }
  @$pb.TagNumber(35)
  $core.bool hasB26() => $_has(34);
  @$pb.TagNumber(35)
  void clearB26() => clearField(35);

  @$pb.TagNumber(36)
  $core.bool get b27 => $_getBF(35);
  @$pb.TagNumber(36)
  set b27($core.bool v) { $_setBool(35, v); }
  @$pb.TagNumber(36)
  $core.bool hasB27() => $_has(35);
  @$pb.TagNumber(36)
  void clearB27() => clearField(36);

  @$pb.TagNumber(37)
  $core.bool get b28 => $_getBF(36);
  @$pb.TagNumber(37)
  set b28($core.bool v) { $_setBool(36, v); }
  @$pb.TagNumber(37)
  $core.bool hasB28() => $_has(36);
  @$pb.TagNumber(37)
  void clearB28() => clearField(37);

  @$pb.TagNumber(38)
  $core.bool get b29 => $_getBF(37);
  @$pb.TagNumber(38)
  set b29($core.bool v) { $_setBool(37, v); }
  @$pb.TagNumber(38)
  $core.bool hasB29() => $_has(37);
  @$pb.TagNumber(38)
  void clearB29() => clearField(38);

  @$pb.TagNumber(39)
  $core.bool get b30 => $_getBF(38);
  @$pb.TagNumber(39)
  set b30($core.bool v) { $_setBool(38, v); }
  @$pb.TagNumber(39)
  $core.bool hasB30() => $_has(38);
  @$pb.TagNumber(39)
  void clearB30() => clearField(39);

  @$pb.TagNumber(40)
  $core.bool get b31 => $_getBF(39);
  @$pb.TagNumber(40)
  set b31($core.bool v) { $_setBool(39, v); }
  @$pb.TagNumber(40)
  $core.bool hasB31() => $_has(39);
  @$pb.TagNumber(40)
  void clearB31() => clearField(40);

  @$pb.TagNumber(41)
  $core.bool get b32 => $_getBF(40);
  @$pb.TagNumber(41)
  set b32($core.bool v) { $_setBool(40, v); }
  @$pb.TagNumber(41)
  $core.bool hasB32() => $_has(40);
  @$pb.TagNumber(41)
  void clearB32() => clearField(41);

  @$pb.TagNumber(42)
  $core.bool get b33 => $_getBF(41);
  @$pb.TagNumber(42)
  set b33($core.bool v) { $_setBool(41, v); }
  @$pb.TagNumber(42)
  $core.bool hasB33() => $_has(41);
  @$pb.TagNumber(42)
  void clearB33() => clearField(42);

  @$pb.TagNumber(43)
  $core.bool get b34 => $_getBF(42);
  @$pb.TagNumber(43)
  set b34($core.bool v) { $_setBool(42, v); }
  @$pb.TagNumber(43)
  $core.bool hasB34() => $_has(42);
  @$pb.TagNumber(43)
  void clearB34() => clearField(43);

  @$pb.TagNumber(44)
  $core.bool get b35 => $_getBF(43);
  @$pb.TagNumber(44)
  set b35($core.bool v) { $_setBool(43, v); }
  @$pb.TagNumber(44)
  $core.bool hasB35() => $_has(43);
  @$pb.TagNumber(44)
  void clearB35() => clearField(44);

  @$pb.TagNumber(45)
  $core.bool get b36 => $_getBF(44);
  @$pb.TagNumber(45)
  set b36($core.bool v) { $_setBool(44, v); }
  @$pb.TagNumber(45)
  $core.bool hasB36() => $_has(44);
  @$pb.TagNumber(45)
  void clearB36() => clearField(45);

  @$pb.TagNumber(46)
  $core.bool get b37 => $_getBF(45);
  @$pb.TagNumber(46)
  set b37($core.bool v) { $_setBool(45, v); }
  @$pb.TagNumber(46)
  $core.bool hasB37() => $_has(45);
  @$pb.TagNumber(46)
  void clearB37() => clearField(46);

  @$pb.TagNumber(47)
  $core.bool get b38 => $_getBF(46);
  @$pb.TagNumber(47)
  set b38($core.bool v) { $_setBool(46, v); }
  @$pb.TagNumber(47)
  $core.bool hasB38() => $_has(46);
  @$pb.TagNumber(47)
  void clearB38() => clearField(47);

  @$pb.TagNumber(48)
  $core.bool get b39 => $_getBF(47);
  @$pb.TagNumber(48)
  set b39($core.bool v) { $_setBool(47, v); }
  @$pb.TagNumber(48)
  $core.bool hasB39() => $_has(47);
  @$pb.TagNumber(48)
  void clearB39() => clearField(48);

  @$pb.TagNumber(49)
  $core.bool get b40 => $_getBF(48);
  @$pb.TagNumber(49)
  set b40($core.bool v) { $_setBool(48, v); }
  @$pb.TagNumber(49)
  $core.bool hasB40() => $_has(48);
  @$pb.TagNumber(49)
  void clearB40() => clearField(49);

  @$pb.TagNumber(50)
  $core.bool get b41 => $_getBF(49);
  @$pb.TagNumber(50)
  set b41($core.bool v) { $_setBool(49, v); }
  @$pb.TagNumber(50)
  $core.bool hasB41() => $_has(49);
  @$pb.TagNumber(50)
  void clearB41() => clearField(50);

  @$pb.TagNumber(51)
  $core.bool get b42 => $_getBF(50);
  @$pb.TagNumber(51)
  set b42($core.bool v) { $_setBool(50, v); }
  @$pb.TagNumber(51)
  $core.bool hasB42() => $_has(50);
  @$pb.TagNumber(51)
  void clearB42() => clearField(51);

  @$pb.TagNumber(52)
  $core.bool get b43 => $_getBF(51);
  @$pb.TagNumber(52)
  set b43($core.bool v) { $_setBool(51, v); }
  @$pb.TagNumber(52)
  $core.bool hasB43() => $_has(51);
  @$pb.TagNumber(52)
  void clearB43() => clearField(52);

  @$pb.TagNumber(53)
  $core.bool get b44 => $_getBF(52);
  @$pb.TagNumber(53)
  set b44($core.bool v) { $_setBool(52, v); }
  @$pb.TagNumber(53)
  $core.bool hasB44() => $_has(52);
  @$pb.TagNumber(53)
  void clearB44() => clearField(53);

  @$pb.TagNumber(54)
  $core.bool get b45 => $_getBF(53);
  @$pb.TagNumber(54)
  set b45($core.bool v) { $_setBool(53, v); }
  @$pb.TagNumber(54)
  $core.bool hasB45() => $_has(53);
  @$pb.TagNumber(54)
  void clearB45() => clearField(54);

  @$pb.TagNumber(55)
  $core.bool get b46 => $_getBF(54);
  @$pb.TagNumber(55)
  set b46($core.bool v) { $_setBool(54, v); }
  @$pb.TagNumber(55)
  $core.bool hasB46() => $_has(54);
  @$pb.TagNumber(55)
  void clearB46() => clearField(55);

  @$pb.TagNumber(56)
  $core.bool get b47 => $_getBF(55);
  @$pb.TagNumber(56)
  set b47($core.bool v) { $_setBool(55, v); }
  @$pb.TagNumber(56)
  $core.bool hasB47() => $_has(55);
  @$pb.TagNumber(56)
  void clearB47() => clearField(56);

  @$pb.TagNumber(57)
  $core.bool get b48 => $_getBF(56);
  @$pb.TagNumber(57)
  set b48($core.bool v) { $_setBool(56, v); }
  @$pb.TagNumber(57)
  $core.bool hasB48() => $_has(56);
  @$pb.TagNumber(57)
  void clearB48() => clearField(57);

  @$pb.TagNumber(58)
  $core.bool get b49 => $_getBF(57);
  @$pb.TagNumber(58)
  set b49($core.bool v) { $_setBool(57, v); }
  @$pb.TagNumber(58)
  $core.bool hasB49() => $_has(57);
  @$pb.TagNumber(58)
  void clearB49() => clearField(58);

  @$pb.TagNumber(59)
  $core.int get fid => $_getIZ(58);
  @$pb.TagNumber(59)
  set fid($core.int v) { $_setUnsignedInt32(58, v); }
  @$pb.TagNumber(59)
  $core.bool hasFid() => $_has(58);
  @$pb.TagNumber(59)
  void clearFid() => clearField(59);

  @$pb.TagNumber(60)
  $core.int get xMin => $_getIZ(59);
  @$pb.TagNumber(60)
  set xMin($core.int v) { $_setSignedInt32(59, v); }
  @$pb.TagNumber(60)
  $core.bool hasXMin() => $_has(59);
  @$pb.TagNumber(60)
  void clearXMin() => clearField(60);

  @$pb.TagNumber(61)
  $core.int get xCentr => $_getIZ(60);
  @$pb.TagNumber(61)
  set xCentr($core.int v) { $_setSignedInt32(60, v); }
  @$pb.TagNumber(61)
  $core.bool hasXCentr() => $_has(60);
  @$pb.TagNumber(61)
  void clearXCentr() => clearField(61);

  @$pb.TagNumber(62)
  $core.int get xMax => $_getIZ(61);
  @$pb.TagNumber(62)
  set xMax($core.int v) { $_setSignedInt32(61, v); }
  @$pb.TagNumber(62)
  $core.bool hasXMax() => $_has(61);
  @$pb.TagNumber(62)
  void clearXMax() => clearField(62);

  @$pb.TagNumber(63)
  $core.int get xAveraging => $_getIZ(62);
  @$pb.TagNumber(63)
  set xAveraging($core.int v) { $_setUnsignedInt32(62, v); }
  @$pb.TagNumber(63)
  $core.bool hasXAveraging() => $_has(62);
  @$pb.TagNumber(63)
  void clearXAveraging() => clearField(63);

  @$pb.TagNumber(64)
  $core.int get xDeadZone => $_getIZ(63);
  @$pb.TagNumber(64)
  set xDeadZone($core.int v) { $_setUnsignedInt32(63, v); }
  @$pb.TagNumber(64)
  $core.bool hasXDeadZone() => $_has(63);
  @$pb.TagNumber(64)
  void clearXDeadZone() => clearField(64);

  @$pb.TagNumber(65)
  $core.int get yMin => $_getIZ(64);
  @$pb.TagNumber(65)
  set yMin($core.int v) { $_setSignedInt32(64, v); }
  @$pb.TagNumber(65)
  $core.bool hasYMin() => $_has(64);
  @$pb.TagNumber(65)
  void clearYMin() => clearField(65);

  @$pb.TagNumber(66)
  $core.int get yCentr => $_getIZ(65);
  @$pb.TagNumber(66)
  set yCentr($core.int v) { $_setSignedInt32(65, v); }
  @$pb.TagNumber(66)
  $core.bool hasYCentr() => $_has(65);
  @$pb.TagNumber(66)
  void clearYCentr() => clearField(66);

  @$pb.TagNumber(67)
  $core.int get yMax => $_getIZ(66);
  @$pb.TagNumber(67)
  set yMax($core.int v) { $_setSignedInt32(66, v); }
  @$pb.TagNumber(67)
  $core.bool hasYMax() => $_has(66);
  @$pb.TagNumber(67)
  void clearYMax() => clearField(67);

  @$pb.TagNumber(68)
  $core.int get yAveraging => $_getIZ(67);
  @$pb.TagNumber(68)
  set yAveraging($core.int v) { $_setUnsignedInt32(67, v); }
  @$pb.TagNumber(68)
  $core.bool hasYAveraging() => $_has(67);
  @$pb.TagNumber(68)
  void clearYAveraging() => clearField(68);

  @$pb.TagNumber(69)
  $core.int get yDeadZone => $_getIZ(68);
  @$pb.TagNumber(69)
  set yDeadZone($core.int v) { $_setUnsignedInt32(68, v); }
  @$pb.TagNumber(69)
  $core.bool hasYDeadZone() => $_has(68);
  @$pb.TagNumber(69)
  void clearYDeadZone() => clearField(69);

  @$pb.TagNumber(70)
  $core.int get zMin => $_getIZ(69);
  @$pb.TagNumber(70)
  set zMin($core.int v) { $_setSignedInt32(69, v); }
  @$pb.TagNumber(70)
  $core.bool hasZMin() => $_has(69);
  @$pb.TagNumber(70)
  void clearZMin() => clearField(70);

  @$pb.TagNumber(71)
  $core.int get zCentr => $_getIZ(70);
  @$pb.TagNumber(71)
  set zCentr($core.int v) { $_setSignedInt32(70, v); }
  @$pb.TagNumber(71)
  $core.bool hasZCentr() => $_has(70);
  @$pb.TagNumber(71)
  void clearZCentr() => clearField(71);

  @$pb.TagNumber(72)
  $core.int get zMax => $_getIZ(71);
  @$pb.TagNumber(72)
  set zMax($core.int v) { $_setSignedInt32(71, v); }
  @$pb.TagNumber(72)
  $core.bool hasZMax() => $_has(71);
  @$pb.TagNumber(72)
  void clearZMax() => clearField(72);

  @$pb.TagNumber(73)
  $core.int get zAveraging => $_getIZ(72);
  @$pb.TagNumber(73)
  set zAveraging($core.int v) { $_setUnsignedInt32(72, v); }
  @$pb.TagNumber(73)
  $core.bool hasZAveraging() => $_has(72);
  @$pb.TagNumber(73)
  void clearZAveraging() => clearField(73);

  @$pb.TagNumber(74)
  $core.int get zDeadZone => $_getIZ(73);
  @$pb.TagNumber(74)
  set zDeadZone($core.int v) { $_setUnsignedInt32(73, v); }
  @$pb.TagNumber(74)
  $core.bool hasZDeadZone() => $_has(73);
  @$pb.TagNumber(74)
  void clearZDeadZone() => clearField(74);

  @$pb.TagNumber(75)
  $core.int get rxMin => $_getIZ(74);
  @$pb.TagNumber(75)
  set rxMin($core.int v) { $_setSignedInt32(74, v); }
  @$pb.TagNumber(75)
  $core.bool hasRxMin() => $_has(74);
  @$pb.TagNumber(75)
  void clearRxMin() => clearField(75);

  @$pb.TagNumber(76)
  $core.int get rxCentr => $_getIZ(75);
  @$pb.TagNumber(76)
  set rxCentr($core.int v) { $_setSignedInt32(75, v); }
  @$pb.TagNumber(76)
  $core.bool hasRxCentr() => $_has(75);
  @$pb.TagNumber(76)
  void clearRxCentr() => clearField(76);

  @$pb.TagNumber(77)
  $core.int get rxMax => $_getIZ(76);
  @$pb.TagNumber(77)
  set rxMax($core.int v) { $_setSignedInt32(76, v); }
  @$pb.TagNumber(77)
  $core.bool hasRxMax() => $_has(76);
  @$pb.TagNumber(77)
  void clearRxMax() => clearField(77);

  @$pb.TagNumber(78)
  $core.int get rxAveraging => $_getIZ(77);
  @$pb.TagNumber(78)
  set rxAveraging($core.int v) { $_setUnsignedInt32(77, v); }
  @$pb.TagNumber(78)
  $core.bool hasRxAveraging() => $_has(77);
  @$pb.TagNumber(78)
  void clearRxAveraging() => clearField(78);

  @$pb.TagNumber(79)
  $core.int get rxDeadZone => $_getIZ(78);
  @$pb.TagNumber(79)
  set rxDeadZone($core.int v) { $_setUnsignedInt32(78, v); }
  @$pb.TagNumber(79)
  $core.bool hasRxDeadZone() => $_has(78);
  @$pb.TagNumber(79)
  void clearRxDeadZone() => clearField(79);

  @$pb.TagNumber(80)
  $core.int get ryMin => $_getIZ(79);
  @$pb.TagNumber(80)
  set ryMin($core.int v) { $_setSignedInt32(79, v); }
  @$pb.TagNumber(80)
  $core.bool hasRyMin() => $_has(79);
  @$pb.TagNumber(80)
  void clearRyMin() => clearField(80);

  @$pb.TagNumber(81)
  $core.int get ryCentr => $_getIZ(80);
  @$pb.TagNumber(81)
  set ryCentr($core.int v) { $_setSignedInt32(80, v); }
  @$pb.TagNumber(81)
  $core.bool hasRyCentr() => $_has(80);
  @$pb.TagNumber(81)
  void clearRyCentr() => clearField(81);

  @$pb.TagNumber(82)
  $core.int get ryMax => $_getIZ(81);
  @$pb.TagNumber(82)
  set ryMax($core.int v) { $_setSignedInt32(81, v); }
  @$pb.TagNumber(82)
  $core.bool hasRyMax() => $_has(81);
  @$pb.TagNumber(82)
  void clearRyMax() => clearField(82);

  @$pb.TagNumber(83)
  $core.int get ryAveraging => $_getIZ(82);
  @$pb.TagNumber(83)
  set ryAveraging($core.int v) { $_setUnsignedInt32(82, v); }
  @$pb.TagNumber(83)
  $core.bool hasRyAveraging() => $_has(82);
  @$pb.TagNumber(83)
  void clearRyAveraging() => clearField(83);

  @$pb.TagNumber(84)
  $core.int get ryDeadZone => $_getIZ(83);
  @$pb.TagNumber(84)
  set ryDeadZone($core.int v) { $_setUnsignedInt32(83, v); }
  @$pb.TagNumber(84)
  $core.bool hasRyDeadZone() => $_has(83);
  @$pb.TagNumber(84)
  void clearRyDeadZone() => clearField(84);

  @$pb.TagNumber(85)
  $core.int get rzMin => $_getIZ(84);
  @$pb.TagNumber(85)
  set rzMin($core.int v) { $_setSignedInt32(84, v); }
  @$pb.TagNumber(85)
  $core.bool hasRzMin() => $_has(84);
  @$pb.TagNumber(85)
  void clearRzMin() => clearField(85);

  @$pb.TagNumber(87)
  $core.int get rzMax => $_getIZ(85);
  @$pb.TagNumber(87)
  set rzMax($core.int v) { $_setSignedInt32(85, v); }
  @$pb.TagNumber(87)
  $core.bool hasRzMax() => $_has(85);
  @$pb.TagNumber(87)
  void clearRzMax() => clearField(87);

  @$pb.TagNumber(88)
  $core.int get rzAveraging => $_getIZ(86);
  @$pb.TagNumber(88)
  set rzAveraging($core.int v) { $_setUnsignedInt32(86, v); }
  @$pb.TagNumber(88)
  $core.bool hasRzAveraging() => $_has(86);
  @$pb.TagNumber(88)
  void clearRzAveraging() => clearField(88);

  @$pb.TagNumber(89)
  $core.int get rzDeadZone => $_getIZ(87);
  @$pb.TagNumber(89)
  set rzDeadZone($core.int v) { $_setUnsignedInt32(87, v); }
  @$pb.TagNumber(89)
  $core.bool hasRzDeadZone() => $_has(87);
  @$pb.TagNumber(89)
  void clearRzDeadZone() => clearField(89);

  @$pb.TagNumber(90)
  $core.int get sliderMin => $_getIZ(88);
  @$pb.TagNumber(90)
  set sliderMin($core.int v) { $_setSignedInt32(88, v); }
  @$pb.TagNumber(90)
  $core.bool hasSliderMin() => $_has(88);
  @$pb.TagNumber(90)
  void clearSliderMin() => clearField(90);

  @$pb.TagNumber(91)
  $core.int get sliderMax => $_getIZ(89);
  @$pb.TagNumber(91)
  set sliderMax($core.int v) { $_setSignedInt32(89, v); }
  @$pb.TagNumber(91)
  $core.bool hasSliderMax() => $_has(89);
  @$pb.TagNumber(91)
  void clearSliderMax() => clearField(91);

  @$pb.TagNumber(92)
  $core.int get sliderAveraging => $_getIZ(90);
  @$pb.TagNumber(92)
  set sliderAveraging($core.int v) { $_setUnsignedInt32(90, v); }
  @$pb.TagNumber(92)
  $core.bool hasSliderAveraging() => $_has(90);
  @$pb.TagNumber(92)
  void clearSliderAveraging() => clearField(92);

  @$pb.TagNumber(93)
  $core.int get sliderDeadZone => $_getIZ(91);
  @$pb.TagNumber(93)
  set sliderDeadZone($core.int v) { $_setUnsignedInt32(91, v); }
  @$pb.TagNumber(93)
  $core.bool hasSliderDeadZone() => $_has(91);
  @$pb.TagNumber(93)
  void clearSliderDeadZone() => clearField(93);

  @$pb.TagNumber(94)
  $core.int get encoderTime => $_getIZ(92);
  @$pb.TagNumber(94)
  set encoderTime($core.int v) { $_setUnsignedInt32(92, v); }
  @$pb.TagNumber(94)
  $core.bool hasEncoderTime() => $_has(92);
  @$pb.TagNumber(94)
  void clearEncoderTime() => clearField(94);

  @$pb.TagNumber(95)
  $core.int get ledR => $_getIZ(93);
  @$pb.TagNumber(95)
  set ledR($core.int v) { $_setUnsignedInt32(93, v); }
  @$pb.TagNumber(95)
  $core.bool hasLedR() => $_has(93);
  @$pb.TagNumber(95)
  void clearLedR() => clearField(95);

  @$pb.TagNumber(96)
  $core.int get ledG => $_getIZ(94);
  @$pb.TagNumber(96)
  set ledG($core.int v) { $_setUnsignedInt32(94, v); }
  @$pb.TagNumber(96)
  $core.bool hasLedG() => $_has(94);
  @$pb.TagNumber(96)
  void clearLedG() => clearField(96);

  @$pb.TagNumber(97)
  $core.int get ledB => $_getIZ(95);
  @$pb.TagNumber(97)
  set ledB($core.int v) { $_setUnsignedInt32(95, v); }
  @$pb.TagNumber(97)
  $core.bool hasLedB() => $_has(95);
  @$pb.TagNumber(97)
  void clearLedB() => clearField(97);

  @$pb.TagNumber(98)
  $core.int get idGrib => $_getIZ(96);
  @$pb.TagNumber(98)
  set idGrib($core.int v) { $_setUnsignedInt32(96, v); }
  @$pb.TagNumber(98)
  $core.bool hasIdGrib() => $_has(96);
  @$pb.TagNumber(98)
  void clearIdGrib() => clearField(98);

  @$pb.TagNumber(99)
  $core.int get hatka1Mode => $_getIZ(97);
  @$pb.TagNumber(99)
  set hatka1Mode($core.int v) { $_setUnsignedInt32(97, v); }
  @$pb.TagNumber(99)
  $core.bool hasHatka1Mode() => $_has(97);
  @$pb.TagNumber(99)
  void clearHatka1Mode() => clearField(99);

  @$pb.TagNumber(100)
  $core.int get hatka2Mode => $_getIZ(98);
  @$pb.TagNumber(100)
  set hatka2Mode($core.int v) { $_setUnsignedInt32(98, v); }
  @$pb.TagNumber(100)
  $core.bool hasHatka2Mode() => $_has(98);
  @$pb.TagNumber(100)
  void clearHatka2Mode() => clearField(100);

  @$pb.TagNumber(101)
  $core.int get hatka3Mode => $_getIZ(99);
  @$pb.TagNumber(101)
  set hatka3Mode($core.int v) { $_setUnsignedInt32(99, v); }
  @$pb.TagNumber(101)
  $core.bool hasHatka3Mode() => $_has(99);
  @$pb.TagNumber(101)
  void clearHatka3Mode() => clearField(101);

  @$pb.TagNumber(102)
  $core.int get hatka4Mode => $_getIZ(100);
  @$pb.TagNumber(102)
  set hatka4Mode($core.int v) { $_setUnsignedInt32(100, v); }
  @$pb.TagNumber(102)
  $core.bool hasHatka4Mode() => $_has(100);
  @$pb.TagNumber(102)
  void clearHatka4Mode() => clearField(102);

  @$pb.TagNumber(103)
  $core.int get controlByte => $_getIZ(101);
  @$pb.TagNumber(103)
  set controlByte($core.int v) { $_setUnsignedInt32(101, v); }
  @$pb.TagNumber(103)
  $core.bool hasControlByte() => $_has(101);
  @$pb.TagNumber(103)
  void clearControlByte() => clearField(103);

  @$pb.TagNumber(104)
  $core.int get gashButton1Min => $_getIZ(102);
  @$pb.TagNumber(104)
  set gashButton1Min($core.int v) { $_setUnsignedInt32(102, v); }
  @$pb.TagNumber(104)
  $core.bool hasGashButton1Min() => $_has(102);
  @$pb.TagNumber(104)
  void clearGashButton1Min() => clearField(104);

  @$pb.TagNumber(105)
  $core.int get gashButton1Max => $_getIZ(103);
  @$pb.TagNumber(105)
  set gashButton1Max($core.int v) { $_setUnsignedInt32(103, v); }
  @$pb.TagNumber(105)
  $core.bool hasGashButton1Max() => $_has(103);
  @$pb.TagNumber(105)
  void clearGashButton1Max() => clearField(105);

  @$pb.TagNumber(106)
  $core.int get gashButton2Min => $_getIZ(104);
  @$pb.TagNumber(106)
  set gashButton2Min($core.int v) { $_setUnsignedInt32(104, v); }
  @$pb.TagNumber(106)
  $core.bool hasGashButton2Min() => $_has(104);
  @$pb.TagNumber(106)
  void clearGashButton2Min() => clearField(106);

  @$pb.TagNumber(107)
  $core.int get gashButton2Max => $_getIZ(105);
  @$pb.TagNumber(107)
  set gashButton2Max($core.int v) { $_setUnsignedInt32(105, v); }
  @$pb.TagNumber(107)
  $core.bool hasGashButton2Max() => $_has(105);
  @$pb.TagNumber(107)
  void clearGashButton2Max() => clearField(107);

  @$pb.TagNumber(108)
  $core.int get gashButton3Min => $_getIZ(106);
  @$pb.TagNumber(108)
  set gashButton3Min($core.int v) { $_setUnsignedInt32(106, v); }
  @$pb.TagNumber(108)
  $core.bool hasGashButton3Min() => $_has(106);
  @$pb.TagNumber(108)
  void clearGashButton3Min() => clearField(108);

  @$pb.TagNumber(109)
  $core.int get gashButton3Max => $_getIZ(107);
  @$pb.TagNumber(109)
  set gashButton3Max($core.int v) { $_setUnsignedInt32(107, v); }
  @$pb.TagNumber(109)
  $core.bool hasGashButton3Max() => $_has(107);
  @$pb.TagNumber(109)
  void clearGashButton3Max() => clearField(109);

  @$pb.TagNumber(110)
  $core.int get spiErrorCnt => $_getIZ(108);
  @$pb.TagNumber(110)
  set spiErrorCnt($core.int v) { $_setSignedInt32(108, v); }
  @$pb.TagNumber(110)
  $core.bool hasSpiErrorCnt() => $_has(108);
  @$pb.TagNumber(110)
  void clearSpiErrorCnt() => clearField(110);

  @$pb.TagNumber(111)
  $fixnum.Int64 get fbuttons => $_getI64(109);
  @$pb.TagNumber(111)
  set fbuttons($fixnum.Int64 v) { $_setInt64(109, v); }
  @$pb.TagNumber(111)
  $core.bool hasFbuttons() => $_has(109);
  @$pb.TagNumber(111)
  void clearFbuttons() => clearField(111);

  @$pb.TagNumber(112)
  $core.int get xAxis => $_getIZ(110);
  @$pb.TagNumber(112)
  set xAxis($core.int v) { $_setSignedInt32(110, v); }
  @$pb.TagNumber(112)
  $core.bool hasXAxis() => $_has(110);
  @$pb.TagNumber(112)
  void clearXAxis() => clearField(112);

  @$pb.TagNumber(113)
  $core.int get yAxis => $_getIZ(111);
  @$pb.TagNumber(113)
  set yAxis($core.int v) { $_setSignedInt32(111, v); }
  @$pb.TagNumber(113)
  $core.bool hasYAxis() => $_has(111);
  @$pb.TagNumber(113)
  void clearYAxis() => clearField(113);

  @$pb.TagNumber(114)
  $core.int get zAxis => $_getIZ(112);
  @$pb.TagNumber(114)
  set zAxis($core.int v) { $_setSignedInt32(112, v); }
  @$pb.TagNumber(114)
  $core.bool hasZAxis() => $_has(112);
  @$pb.TagNumber(114)
  void clearZAxis() => clearField(114);

  @$pb.TagNumber(115)
  $core.int get rxAxis => $_getIZ(113);
  @$pb.TagNumber(115)
  set rxAxis($core.int v) { $_setSignedInt32(113, v); }
  @$pb.TagNumber(115)
  $core.bool hasRxAxis() => $_has(113);
  @$pb.TagNumber(115)
  void clearRxAxis() => clearField(115);

  @$pb.TagNumber(116)
  $core.int get ryAxis => $_getIZ(114);
  @$pb.TagNumber(116)
  set ryAxis($core.int v) { $_setSignedInt32(114, v); }
  @$pb.TagNumber(116)
  $core.bool hasRyAxis() => $_has(114);
  @$pb.TagNumber(116)
  void clearRyAxis() => clearField(116);

  @$pb.TagNumber(117)
  $core.int get rzAxis => $_getIZ(115);
  @$pb.TagNumber(117)
  set rzAxis($core.int v) { $_setSignedInt32(115, v); }
  @$pb.TagNumber(117)
  $core.bool hasRzAxis() => $_has(115);
  @$pb.TagNumber(117)
  void clearRzAxis() => clearField(117);

  @$pb.TagNumber(118)
  $core.int get sliderAxis => $_getIZ(116);
  @$pb.TagNumber(118)
  set sliderAxis($core.int v) { $_setSignedInt32(116, v); }
  @$pb.TagNumber(118)
  $core.bool hasSliderAxis() => $_has(116);
  @$pb.TagNumber(118)
  void clearSliderAxis() => clearField(118);

  @$pb.TagNumber(119)
  $core.int get fwVersion => $_getIZ(117);
  @$pb.TagNumber(119)
  set fwVersion($core.int v) { $_setUnsignedInt32(117, v); }
  @$pb.TagNumber(119)
  $core.bool hasFwVersion() => $_has(117);
  @$pb.TagNumber(119)
  void clearFwVersion() => clearField(119);

  @$pb.TagNumber(120)
  $core.bool get connected => $_getBF(118);
  @$pb.TagNumber(120)
  set connected($core.bool v) { $_setBool(118, v); }
  @$pb.TagNumber(120)
  $core.bool hasConnected() => $_has(118);
  @$pb.TagNumber(120)
  void clearConnected() => clearField(120);

  @$pb.TagNumber(121)
  $core.String get baseName => $_getSZ(119);
  @$pb.TagNumber(121)
  set baseName($core.String v) { $_setString(119, v); }
  @$pb.TagNumber(121)
  $core.bool hasBaseName() => $_has(119);
  @$pb.TagNumber(121)
  void clearBaseName() => clearField(121);

  @$pb.TagNumber(122)
  $core.String get side => $_getSZ(120);
  @$pb.TagNumber(122)
  set side($core.String v) { $_setString(120, v); }
  @$pb.TagNumber(122)
  $core.bool hasSide() => $_has(120);
  @$pb.TagNumber(122)
  void clearSide() => clearField(122);

  @$pb.TagNumber(123)
  $core.bool get moreThanTwo => $_getBF(121);
  @$pb.TagNumber(123)
  set moreThanTwo($core.bool v) { $_setBool(121, v); }
  @$pb.TagNumber(123)
  $core.bool hasMoreThanTwo() => $_has(121);
  @$pb.TagNumber(123)
  void clearMoreThanTwo() => clearField(123);

  @$pb.TagNumber(124)
  $core.bool get dfuOn => $_getBF(122);
  @$pb.TagNumber(124)
  set dfuOn($core.bool v) { $_setBool(122, v); }
  @$pb.TagNumber(124)
  $core.bool hasDfuOn() => $_has(122);
  @$pb.TagNumber(124)
  void clearDfuOn() => clearField(124);

  @$pb.TagNumber(125)
  $core.bool get fwUpdateAvailable => $_getBF(123);
  @$pb.TagNumber(125)
  set fwUpdateAvailable($core.bool v) { $_setBool(123, v); }
  @$pb.TagNumber(125)
  $core.bool hasFwUpdateAvailable() => $_has(123);
  @$pb.TagNumber(125)
  void clearFwUpdateAvailable() => clearField(125);

  @$pb.TagNumber(126)
  $core.bool get invertedX => $_getBF(124);
  @$pb.TagNumber(126)
  set invertedX($core.bool v) { $_setBool(124, v); }
  @$pb.TagNumber(126)
  $core.bool hasInvertedX() => $_has(124);
  @$pb.TagNumber(126)
  void clearInvertedX() => clearField(126);

  @$pb.TagNumber(127)
  $core.bool get invertedY => $_getBF(125);
  @$pb.TagNumber(127)
  set invertedY($core.bool v) { $_setBool(125, v); }
  @$pb.TagNumber(127)
  $core.bool hasInvertedY() => $_has(125);
  @$pb.TagNumber(127)
  void clearInvertedY() => clearField(127);

  @$pb.TagNumber(128)
  $core.bool get invertedZ => $_getBF(126);
  @$pb.TagNumber(128)
  set invertedZ($core.bool v) { $_setBool(126, v); }
  @$pb.TagNumber(128)
  $core.bool hasInvertedZ() => $_has(126);
  @$pb.TagNumber(128)
  void clearInvertedZ() => clearField(128);

  @$pb.TagNumber(129)
  $core.bool get invertedRx => $_getBF(127);
  @$pb.TagNumber(129)
  set invertedRx($core.bool v) { $_setBool(127, v); }
  @$pb.TagNumber(129)
  $core.bool hasInvertedRx() => $_has(127);
  @$pb.TagNumber(129)
  void clearInvertedRx() => clearField(129);

  @$pb.TagNumber(130)
  $core.bool get invertedRy => $_getBF(128);
  @$pb.TagNumber(130)
  set invertedRy($core.bool v) { $_setBool(128, v); }
  @$pb.TagNumber(130)
  $core.bool hasInvertedRy() => $_has(128);
  @$pb.TagNumber(130)
  void clearInvertedRy() => clearField(130);

  @$pb.TagNumber(131)
  $core.bool get invertedRz => $_getBF(129);
  @$pb.TagNumber(131)
  set invertedRz($core.bool v) { $_setBool(129, v); }
  @$pb.TagNumber(131)
  $core.bool hasInvertedRz() => $_has(129);
  @$pb.TagNumber(131)
  void clearInvertedRz() => clearField(131);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');

const ID = 3;