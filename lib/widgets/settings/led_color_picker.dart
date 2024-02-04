import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:FC_Technologies/messages/report_message.pb.dart' as reportMessage;
import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:FC_Technologies/messages/device_info.pb.dart' as deviceInfo;


class LedColorPicker extends StatefulWidget {
  final reportMessage.ReportMessage data;

  const LedColorPicker({Key? key, required this.data}) : super(key: key);

  @override
  State<LedColorPicker> createState() => _LedColorPickerState();
}

class LEDS {
  int ledR;
  int ledG;
  int ledB;

  LEDS(this.ledR, this.ledG, this.ledB);

  // Copy constructor
  LEDS.copy(LEDS other) : 
    ledR = other.ledR,
    ledG = other.ledG,
    ledB = other.ledB; 
}

class _LedColorPickerState extends State<LedColorPicker> {
  

  HSVColor _color = HSVColor.fromColor(Colors.red);

  Future<void> rust_request(message, value1, value2, value3, value4, RustOperation operation) async {
    final requestMessage = deviceInfo.SetValues(
      target: message,
      value1: value1,
      value2: value2,
      value3: value3,
      value4: value4,
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


  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        Text('${_color})}'),
        WheelPicker(
          showPalette: true,
          color: _color,
          onChanged: (value) {         
            setState(() {
              _color = value;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                foregroundColor: Colors.white),
            child: const Text('Apply & Save'),
            onPressed: () {
              final c = _color.toColor();
              rust_request('discalibratehandle', 0, 0, 0, 0, RustOperation.Update);
              rust_request('discalibratebase', 0, 0, 0, 0, RustOperation.Update);
              rust_request('apply', 0, 0, 0, 0, RustOperation.Update);
              rust_request('setled', c.red, c.green, c.blue, 0, RustOperation.Update);
              rust_request('apply', 0, 0, 0, 0, RustOperation.Update);
              rust_request('save', 0, 0, 0, 0, RustOperation.Update);
            },
          ),
        )
      ]);
    }
}