import 'package:flutter/material.dart';

import 'package:flutter_multi_slider/flutter_multi_slider.dart';
import 'package:flicon/messages/report_message.pb.dart' as reportMessage;
import 'package:integer/integer.dart';
import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:flicon/messages/device_info.pb.dart' as deviceInfo;

class Brake extends StatefulWidget {
  final reportMessage.ReportMessage data;
  const Brake({Key? key, required this.data}) : super(key: key);

  @override
  State<Brake> createState() => _BrakeState();
}

class _BrakeState extends State<Brake> {

  double _currentDeadZoneValue = 0;
  double _editableDeadZoneValue = 0;
  bool deadZoneChanged = false;

  bool _showCalibation = true;

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

    _currentDeadZoneValue = widget.data.sliderDeadZone.toDouble();

    return Column(
      children: [
        Stack(
          children: <Widget>[
            Container(
              width: 250,
              height: 30,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(193, 10, 10, 1),
                shape: BoxShape.rectangle,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: (widget.data.slider * 250 / widget.data.sliderMax ).toDouble(),
                height: 30,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(132, 5, 5, 1),
                  shape: BoxShape.rectangle,

                ),
              ),
            ),
          ],
        ),
        Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero),
              backgroundColor: const Color.fromARGB(255, 62, 62, 62),
              foregroundColor: Colors.white),
          child: const Text('Calibrate'),
          onPressed: () => {
            setState(() => _showCalibation = !_showCalibation)
        
          },
        )),

        Text("Slider: ${widget.data.slider} Min: ${widget.data.sliderMin} Max: ${widget.data.sliderMax}"),
        Text("Dead: ${widget.data.sliderDeadZone} Axis: ${widget.data.sliderAxis.i_16} AVG: ${widget.data.sliderAveraging}"),
  
        if(_showCalibation) 
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text('Dead zone : ${deadZoneChanged ? _editableDeadZoneValue.toInt() : _currentDeadZoneValue.toInt()}%'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Slider(
                  value: deadZoneChanged ? _editableDeadZoneValue : _currentDeadZoneValue, 
                  min: 1,
                  max: 50,
                  divisions: 100,
                  activeColor:const Color.fromRGBO(193, 10, 10, 1)  ,
                  onChanged: (value) => {
                    setState(() {
                      if(!deadZoneChanged) {
                        deadZoneChanged = true;
                      }
                      _editableDeadZoneValue = value;
                    })
                  }
                )
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero),
                  backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                  foregroundColor: Colors.white),
                child: const Text('Apply changes'),
                onPressed: () {
                  if(deadZoneChanged) {
                    rust_request('setslider', -2630, 3800, 50, _editableDeadZoneValue.toInt(), RustOperation.Update);
                    rust_request('apply', 0, 0, 0, 0, RustOperation.Update);
                    rust_request('save', 0, 0, 0, 0, RustOperation.Update);
                  }
                },
              ),
            ]
          )

        
      ]);
    }
}