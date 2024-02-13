import 'dart:async';

import 'package:flutter/material.dart';
import 'package:FC_Technologies/messages/report_message.pb.dart' as reportMessage;
import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:FC_Technologies/messages/device_info.pb.dart' as deviceInfo;
class BaseRotation extends StatefulWidget {
  final reportMessage.ReportMessage data;

  const BaseRotation({Key? key, required this.data}) : super(key: key);

  @override
  State<BaseRotation> createState() => _BaseRotationState();
}

class _BaseRotationState extends State<BaseRotation> {

  late Timer _periodicZTimer;

  bool _showCalibation = false;
  bool rAxisCalibration = false;

  // Z VALUES

  var minZValue = 10000000000; 
  var maxZValue = -10000000000; 
  final double _currentZMin = 0;
  bool minZChanged = false;
  final double _currentZMax= 0;
  bool maxZChanged = false;
  bool deadZoneZChanged = false;
  double _editableDeadZoneZValue = 0;
  bool averageZChanged = false;
  double _editableZAverage = 0;
  bool rZAxisCalibration = false;


  bool callbackMessage = false;

  final bool _negativeValue = false;

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

    double rotationAngle = (widget.data.zAxis * 100 / widget.data.zMax) / 4;

    
    return Column(
      children: [
        Transform.rotate(
          angle: 0,
          child: Stack(
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(193, 10, 10, 1),
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                top: 10.0,
                bottom: 10.0,
                left: 10.0,
                child: SizedBox(
                  width: 130,
                  height: 130,
                  child: Transform.flip(
                    flipX: (rotationAngle - 0.5) < 0,
                    child: CircularProgressIndicator(
                      value: (rotationAngle / 100).abs(),
                      strokeWidth: 20.0,
                      valueColor : const AlwaysStoppedAnimation(Color.fromRGBO(132, 5, 5, 1))
                    )
                  )
                ),
              ),
              Positioned(
                top: 10.0,
                bottom: 10.0,
                left: 10.0,
                child: SizedBox(
                  width: 130,
                  height: 130,
                  child: Transform.flip(
                    flipX: _negativeValue,
                    child: CircularProgressIndicator(
                      value: widget.data.zDeadZone / 100 / 2,
                      strokeWidth: 20.0,
                      valueColor : const AlwaysStoppedAnimation(Color.fromRGBO(59, 1, 1, 1))
                    )
                  )
                ),
              ),
              Positioned(
                top: 10.0,
                bottom: 10.0,
                left: 10.0,
                child: SizedBox(
                  width: 130,
                  height: 130,
                  child: Transform.flip(
                    flipX: !_negativeValue,
                    child: CircularProgressIndicator(
                      value: widget.data.zDeadZone / 100 / 2,
                      strokeWidth: 20.0,
                      valueColor : const AlwaysStoppedAnimation(Color.fromRGBO(59, 1, 1, 1))
                    )
                  )
                ),
              ),
          
               Positioned(
                top: 0,
                left: 0,
                child: SizedBox(
                  width: 150,
                  height: 20,
                  child: Center(
                    child: 
                    Text(
                      "${widget.data.zDeadZone} %", 
                      style: const TextStyle(fontSize: 10),
                    )
                  ),
                )
              ),
              Positioned(
                top: 150 / 2 - 35,
                left: 150 / 2 - 35,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(132, 5, 5, 1),
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          ),
        ),

        if(callbackMessage)
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: Container(
              width: 300,
              height: 40,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(2, 42, 22, 1),
                  shape: BoxShape.rectangle,
                ),
              child: const Text('Settings sent to device.'),
            )),
    
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
        if(_showCalibation) 
          Column(
            children: [
              const Divider(
                color: Color.fromRGBO(41, 41, 41, 1)
              ),
              const Padding(
                padding: EdgeInsets.all(5),
                child: Text("Z Axis"),
              ),
              Stack(
                children: <Widget>[
                  const SizedBox(
                    width: 250,
                    height: 20,
                  ),
                  Positioned(
                    top: 5,
                    left: 0,
                    child: Container(
                      width: 250,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(132, 5, 5, 1),
                        shape: BoxShape.rectangle,

                      ),
                    ),
                  ),
                  if(rZAxisCalibration)
                    Positioned(
                      top: 5,
                      left: (((widget.data.xAxis - minZValue) / (maxZValue - minZValue)) * 250).clamp(0, 250) - (250 * (deadZoneZChanged ? _editableDeadZoneZValue.toDouble() : widget.data.zDeadZone.toDouble()) / 100 / 2),
                      child: Container(
                        width: 250 * (deadZoneZChanged ? _editableDeadZoneZValue.toDouble() : widget.data.zDeadZone.toDouble()) / 100,
                        height: 10,
                        decoration: const BoxDecoration(
                          color:Color.fromRGBO(190, 4, 4, 0.8),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ),
                  if(!rZAxisCalibration)
                    Positioned(
                      top: 5,
                      left: 125 - (250 * (deadZoneZChanged ? _editableDeadZoneZValue.toDouble() : widget.data.zDeadZone.toDouble()) / 100 / 2),
                      child: Container(
                        width: 250 * (deadZoneZChanged ? _editableDeadZoneZValue.toDouble() : widget.data.zDeadZone.toDouble()) / 100,
                        height: 10,
                        decoration: const BoxDecoration(
                          color:Color.fromRGBO(190, 4, 4, 0.8),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ),
                  if(rZAxisCalibration)
                    Positioned(
                      top: 0,
                      left:  (((widget.data.xAxis - minZValue) / (maxZValue - minZValue)) * 250).clamp(0, 250) - 10,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(193, 10, 10, 1),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color.fromRGBO(107, 4, 4, 1))
                          ),
                        ),
                      ),
                    
                ],
              ),
              if(rZAxisCalibration)
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Rotate left and right and hold few seconds",
                    textAlign: TextAlign.center,
                  ),
                ),
              if(rZAxisCalibration)
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "to set Z axis MIN and MAX values",
                    textAlign: TextAlign.center,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                    backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                    foregroundColor: Colors.white),
                  child: Text('${rZAxisCalibration ? 'End': 'Start'} calibration'),
                  onPressed: () {
                    setState(() {
                      rZAxisCalibration = !rZAxisCalibration;
                      if(rZAxisCalibration) {
                        minZChanged = true;
                        maxZChanged = true;

                        var valueInZRange = widget.data.zAxis;
                        minZValue = valueInZRange < minZValue ? valueInZRange : minZValue;
                        maxZValue = valueInZRange > maxZValue ? valueInZRange : maxZValue;

                        _periodicZTimer = Timer.periodic(const Duration(milliseconds: 40), (timer) { 
                          var valueInZRange = widget.data.zAxis;
                          minZValue = valueInZRange < minZValue ? valueInZRange : minZValue;
                          maxZValue = valueInZRange > maxZValue ? valueInZRange : maxZValue;
                        });
                      } else {
                        if (_periodicZTimer.isActive) {
                          _periodicZTimer.cancel();
                        }
                      }
                    });
                  },
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text('Dead zone : ${deadZoneZChanged ? _editableDeadZoneZValue.toInt() : widget.data.zDeadZone.toInt()}%'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Slider(
                  value: deadZoneZChanged ? _editableDeadZoneZValue : widget.data.zDeadZone.toDouble(), 
                  min: 0,
                  max: 50,
                  divisions: 50,
                  activeColor:const Color.fromRGBO(193, 10, 10, 1)  ,
                  onChanged: (value) => {
                    setState(() {
                      if(!deadZoneZChanged) {
                        deadZoneZChanged = true;
                      }
                      _editableDeadZoneZValue = value;
                    })
                  }
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text('Averaging: ${averageZChanged ? _editableZAverage.toInt() : widget.data.zAveraging.toInt()}'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Slider(
                  value: averageZChanged ? _editableZAverage : widget.data.zAveraging.toDouble(), 
                  min: 0,
                  max: 255,
                  divisions: 255,
                  activeColor:const Color.fromRGBO(193, 10, 10, 1)  ,
                  onChanged: (value) => {
                    setState(() {
                      if(!averageZChanged) {
                        averageZChanged = true;
                      }
                      _editableZAverage = value;
                    })
                  }
                )
              ),
            
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: 
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                        backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                        foregroundColor: Colors.white),
                    child: const Text('Apply & Save'),
                    onPressed: () {
                      int minZRange = 0;
                      int maxZRange = 0;
                      int averageZ = 0;
                      int deadZoneZ = 0;

                      if(deadZoneZChanged) {
                        deadZoneZ = _editableDeadZoneZValue.toInt();
                        setState(() {
                          deadZoneZChanged = false;
                        });
                      } else {
                        deadZoneZ = widget.data.zDeadZone;
                      }

                      if(averageZChanged) {
                        averageZ = _editableZAverage.toInt();
                        setState(() {
                          averageZChanged = false;
                        });
                      } else {
                        averageZ = widget.data.zAveraging;
                      }

                      if(minZChanged) {
                        minZRange = minZValue;
                        setState(() {
                          minZChanged = false;
                        });
                      } else {
                        minZRange = widget.data.zMin;
                      }

                      if(maxZChanged) {
                        maxZRange = maxZValue;
                        setState(() {
                          maxZChanged = false;
                        });
                      } else {
                        maxZRange = widget.data.zMax;
                      }

                      rust_request('setz', minZRange, maxZRange, averageZ, deadZoneZ, RustOperation.Update);
                      rust_request('save', 0, 0, 0, 0, RustOperation.Update);
                      rust_request('apply', 0, 0, 0, 0, RustOperation.Update);


                      _showCalibation = false;
                      rZAxisCalibration = false;

                      callbackMessage = true;

                      Future.delayed(const Duration(seconds: 5)).then((value) => callbackMessage = false);
                      
                    },
            
                  ),
              )
            ]
          )

        
      ]);
    }
}