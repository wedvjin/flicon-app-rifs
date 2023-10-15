import 'package:rust_in_flutter/rust_in_flutter.dart';

class RustSignalProvider {
  final int resourceID;

  RustSignalProvider(this.resourceID);

  Stream<RustSignal> get rustSignalStream {
    return rustBroadcaster.stream.where((rustSignal) {
      return rustSignal.resource == resourceID;
    });
  }
}