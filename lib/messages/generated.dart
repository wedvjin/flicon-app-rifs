// ignore_for_file: unused_import

import 'dart:typed_data';
import 'package:rinf/rinf.dart';

Future<void> initializeRust() async {
  await prepareInterface(handleRustSignal);
  startRustLogic();
}

Future<void> finalizeRust() async {
  stopRustLogic();
  await Future.delayed(Duration(milliseconds: 10));
}

final signalHandlers = <int, void Function(Uint8List, Uint8List?)>{
};

void handleRustSignal(int messageId, Uint8List messageBytes, Uint8List? blob) {
  signalHandlers[messageId]!(messageBytes, blob);
}
