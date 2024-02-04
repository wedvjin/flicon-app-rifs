import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_multi_slider/flutter_multi_slider.dart';
import 'package:FC_Technologies/messages/report_message.pb.dart' as reportMessage;
import 'package:integer/integer.dart';
import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:FC_Technologies/messages/device_info.pb.dart' as deviceInfo;

class Brake extends StatefulWidget {
  final reportMessage.ReportMessage data;
  const Brake({Key? key, required this.data}) : super(key: key);

  @override
  State<Brake> createState() => _BrakeState();
}

class _BrakeState extends State<Brake> {

  late Timer _periodicTimer;
  
  double _currentDeadZoneValue = 0;
  double _editableDeadZoneValue = 0;
  bool deadZoneChanged = false;

  double _currentAverage = 0;
  double _editableAverage = 0;
  bool averageChanged = false;

  double _currentMin = 0;
  bool minChanged = false;

  double _currentMax= 0;
  bool maxChanged = false;

  var minValue = 10000000000; 
  var maxValue = -10000000000; 

  bool _showCalibation = false;
  bool sliderCalibration = false;

  double _currentRangeValue = 0;
  double _editedRangeMin = -100000000;
  double _editedRangeMax = 1000000000;
  double _editedRangeValue = 0;
  bool rangeEdited = false;
  bool callbackMessage = false;


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
    _currentAverage = widget.data.sliderAveraging.toDouble();
    _currentMin = widget.data.sliderMin.toDouble();
    _currentMax = widget.data.sliderMax.toDouble();

    // double originalProgress = (((widget.data.sliderAxis - widget.data.sliderMin) / (widget.data.sliderMax - widget.data.sliderMin)) * 300);
    // double progress = originalProgress.clamp(0, 300);

    double originalProgress = (((widget.data.slider - 0) / (65536 / 2 - 0)) * 300);
    double progress = originalProgress.clamp(0, 300);

    return Column(
      children: [
        Stack(
          children: <Widget>[
            Container(
              width: 300,
              height: 60,
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 300,
                height: 30,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(193, 10, 10, 1),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: progress,
                height: 30,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(132, 5, 5, 1),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: (300 * _currentDeadZoneValue.toDouble() /100),
                height: 30,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(60, 24, 24, 1),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
            Positioned(
              top: 45,
              left: 0,
              child: Text(
                  'Dead zone ${_currentDeadZoneValue.toInt()} %',
                  style: const TextStyle(
                    fontSize: 10.0,
                  )
                )
              ),
            
          ],
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
              child: Text('Settings sent do device.'),
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
            setState(() {
              _showCalibation = !_showCalibation;

            })
          },
        )),

        if(_showCalibation) 
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child:
                  Stack(
                    children: <Widget>[
                      Container(
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
                        if(sliderCalibration)
                          Positioned(
                            top: 0,
                            left: (((widget.data.sliderAxis - minValue) / (maxValue - minValue)) * 250).clamp(0, 250) - 10,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(193, 10, 10, 1),
                                shape: BoxShape.circle,
                                border: Border.all(color: Color.fromRGBO(107, 4, 4, 1))

                              ),
                            ),
                          ),
                        Positioned(
                          top: 5,
                          left: 0,
                          child: Container(
                            width: deadZoneChanged ? (250 * _editableDeadZoneValue.toDouble() / 100) : (250 * widget.data.rzDeadZone.toDouble() /100),

                            //width: deadZoneChanged ? (250 * _editableDeadZoneValue.toDouble() / 100) : (250 * widget.data.rzDeadZone.toDouble() /100),
                            height: 10,
                            decoration: const BoxDecoration(
                              color:Color.fromRGBO(190, 4, 4, 0.8),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                        ),
                        
                    ],
                  ),
                ),
                  // Stack(
                  //   children: <Widget>[
                  //     Container(
                  //       width: 250,
                  //       height: 10,
                  //     ),
                  //     Positioned(
                  //       top: 0,
                  //       left: 0,
                  //       child: Container(
                  //         width: 250,
                  //         height: 10,
                  //         decoration: const BoxDecoration(
                  //           color: Color.fromRGBO(169, 193, 10, 1),
                  //           shape: BoxShape.rectangle,

                  //         ),
                  //       ),
                  //       ),
                  //     if(sliderCalibration)
                  //       Positioned(
                  //         top: 0,
                  //         left: 0,
                  //         child: Container(
                  //           width: (((widget.data.sliderAxis - minValue) / (maxValue - minValue)) * 250).clamp(0, 250),
                  //           height: 10,
                  //           decoration: const BoxDecoration(
                  //             color: Color.fromRGBO(96, 110, 3, 1),
                  //             shape: BoxShape.rectangle,

                  //           ),
                  //         ),
                  //       ),
                  //       Positioned(
                  //         top: 0,
                  //         left: 0,
                  //         child: Container(
                  //           width: deadZoneChanged ? (250 * _editableDeadZoneValue.toDouble() / 100) : (250 * _currentDeadZoneValue.toDouble() /100),
                  //           height: 10,
                  //           decoration: const BoxDecoration(
                  //             color:Color.fromRGBO(190, 4, 4, 0.8),
                  //             shape: BoxShape.rectangle,
                  //           ),
                  //         ),
                  //       ),
                        
              //       ],
              //     ),
              // ),
              if(sliderCalibration)
                Text('Move slider to get MIN and MAX values'),
              Padding(
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                    backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                    foregroundColor: Colors.white),
                  child: Text('${sliderCalibration ? 'End': 'Start'} calibration'),
                  onPressed: () {
                    setState(() {
                      sliderCalibration = !sliderCalibration;

                      if(sliderCalibration) {
                        minChanged = true;
                        maxChanged = true;
                    
                        var valueInRange = widget.data.sliderAxis;
                        minValue = valueInRange < minValue ? valueInRange : minValue;
                        maxValue = valueInRange > maxValue ? valueInRange : maxValue;

                        _editedRangeValue = maxValue.toDouble();
                        _editedRangeMin = minValue.toDouble();
                        _editedRangeMax = maxValue.toDouble();

                        _periodicTimer = Timer.periodic(Duration(milliseconds: 40), (timer) { 
                          var valueInRange = widget.data.sliderAxis;
                          minValue = valueInRange < minValue ? valueInRange : minValue;
                          maxValue = valueInRange > maxValue ? valueInRange : maxValue;

                          
                          _editedRangeMin = minValue.toDouble();
                          _editedRangeMax = maxValue.toDouble();
                          _editedRangeValue = maxValue.toDouble();

                        });
                      } else {
                        if (_periodicTimer.isActive) {
                          _periodicTimer.cancel();
                        }
                      }
                    });
  
                  },
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text('Averaging: ${averageChanged ? _editableAverage.toInt() : _currentAverage.toInt()}'),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Slider(
                  value: averageChanged ? _editableAverage : _currentAverage, 
                  min: 0,
                  max: 255,
                  divisions: 255,
                  activeColor:const Color.fromRGBO(193, 10, 10, 1)  ,
                  onChanged: (value) => {
                    setState(() {
                      if(!averageChanged) {
                        averageChanged = true;
                      }
                      _editableAverage = value;
                    })
                  }
                )
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text('Dead zone : ${deadZoneChanged ? _editableDeadZoneValue.toInt() : _currentDeadZoneValue.toInt()}%'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Slider(
                  value: deadZoneChanged ? _editableDeadZoneValue : _currentDeadZoneValue, 
                  min: 0,
                  max: 50,
                  divisions: 50,
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
                  int minRange = 0;
                  int maxRange = 0;
                  int average = 0;
                  int deadZone = 0;

                  if(deadZoneChanged) {
                    deadZone = _editableDeadZoneValue.toInt();
                    setState(() {
                      deadZoneChanged = false;
                    });
                  } else {
                    deadZone = _currentDeadZoneValue.toInt();
                  }

                  if(averageChanged) {
                    average = _editableAverage.toInt();
                    setState(() {
                      averageChanged = false;
                    });
                  } else {
                    average = _currentAverage.toInt();
                  }

                  if(minChanged) {
                    minRange = minValue;
                    setState(() {
                      minChanged = false;
                    });
                  } else {
                    minRange = _currentMin.toInt();
                  }

                  if(maxChanged) {
                    maxRange = maxValue;
                    setState(() {
                      maxChanged = false;
                    });
                  } else {
                    maxRange = _currentMax.toInt();
                  }

                  rust_request('setslider', minRange, maxRange, average, deadZone, RustOperation.Update);
                  rust_request('apply', 0, 0, 0, 0, RustOperation.Update);
                  rust_request('save', 0, 0, 0, 0, RustOperation.Update);

                  _showCalibation = false;
                  callbackMessage = true;
                  sliderCalibration = false;

                  Future.delayed(const Duration(seconds: 5)).then((value) => callbackMessage = false);
                  
                },
              ),
            ]
          )

        
      ]);
    }
}