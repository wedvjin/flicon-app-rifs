import 'package:flutter/material.dart';

import 'package:FC_Technologies/messages/report_message.pb.dart' as reportMessage;
import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:FC_Technologies/messages/device_info.pb.dart' as deviceInfo;


class Button3 extends StatefulWidget {
  final reportMessage.ReportMessage data;
  const Button3({Key? key, required this.data}) : super(key: key);

  @override
  State<Button3> createState() => _Button3State();
}


class EncoderTime {
  int time;
  EncoderTime(this.time);
  EncoderTime.copy(EncoderTime other) :  time = other.time; 
}

class _Button3State extends State<Button3> {

  final int _centerPostion = 50;

  final bool _showCalibation = false;

  List<double> calibration = [5, 45, 65, 95];
  bool changed = false;
  double editable = 0;

  Future<deviceInfo.ReadResponse> rust_request(message, value1, value2, value3, value4, RustOperation operation) async {
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
    return responseMessage;
  }


  @override
  Widget build(BuildContext context) {

    double original = widget.data.encoderTime.toDouble();

    String image = 'none';

    if(widget.data.b10 || widget.data.b11 || widget.data.b13 || widget.data.b14) {
      if(widget.data.b10) {
        image = 'one';
      }
      if(widget.data.b11) {
        image = 'two';
      }
      if(widget.data.b13) {
        image = 'top';
      }
      if(widget.data.b14) {
        image = 'bottom';
      }
    } else {
      image = 'none';
    }

    return Column(
      children: [
        Stack(
          children: [
            Positioned(
              child: Image.asset('assets/wheel/$image.png', height: 100),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text('Encoder time: ${changed ?editable.toInt() : original.toInt()}'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Slider(
            value: changed ? editable : original, 
            min: 0,
            max: 255,
            divisions: 255,
            activeColor:const Color.fromRGBO(193, 10, 10, 1)  ,
            onChanged: (value) => {
              setState(() {
                if(!changed) {
                  changed = true;
                }
                editable = value;

              })
            }
          )
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          child: ElevatedButton(
            
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                foregroundColor: Colors.white),
            onPressed: changed ? () => {
              setState(() {
                rust_request('setencoder', editable.toInt(), 0, 0, 0, RustOperation.Update);
                
                rust_request('save', 0, 0, 0, 0, RustOperation.Update);
                rust_request('apply', 0, 0, 0, 0, RustOperation.Update);
                changed = false;
                editable = 0;
              })
          }: null,
            child: const Text('Apply changes'),
        )),
        
      ]);
    }
}