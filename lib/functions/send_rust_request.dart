import 'package:rust_in_flutter/rust_in_flutter.dart';

import 'package:flicon/messages/device_info.pb.dart' as deviceInfo;


Future<void> to_rust(String message, int v1, int v2, int v3, int v4, RustOperation operation) async {
  final requestMessage = deviceInfo.SetValues(
    target: message,
    value1: v1,
    value2: v2,
    value3: v3,
    value4: v4,
  );
  var rustResponse = await requestToRust(RustRequest(
    resource: deviceInfo.ID,
    operation: operation,
    message: requestMessage.writeToBuffer(),
  ));
  var responseMessage =
      deviceInfo.ReadResponse.fromBuffer(
        rustResponse.message!,
      );

}