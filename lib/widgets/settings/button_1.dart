import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_multi_slider/flutter_multi_slider.dart';
import 'package:FC_Technologies/messages/report_message.pb.dart' as reportMessage;
import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:FC_Technologies/messages/device_info.pb.dart' as deviceInfo;

class Button1 extends StatefulWidget {
  final reportMessage.ReportMessage data;
  const Button1({Key? key, required this.data}) : super(key: key);

  @override
  State<Button1> createState() => _Button1State();
}

class _Button1State extends State<Button1> {

  late Timer _periodicXTimer;
  late Timer _periodicYTimer;

  bool _showCalibation = false;
  bool rAxisCalibration = false;

  // X VALUES

  var minXValue = 10000000000; 
  var maxXValue = -10000000000; 
  double _currentXMin = 0;
  bool minXChanged = false;
  double _currentXMax= 0;
  bool maxXChanged = false;
  bool deadZoneXChanged = false;
  double _editableDeadZoneXValue = 0;
  bool averageXChanged = false;
  double _editableXAverage = 0;
  bool rXAxisCalibration = false;


  // Y VALUES

  var minYValue = 10000000000;
  var maxYValue = -10000000000;
  double _currentYMin = 0;
  bool minYChanged = false;
  double _currentYMax= 0;
  bool maxYChanged = false;
  bool deadZoneYChanged = false;
  double _editableDeadZoneYValue = 0;
  bool averageYChanged = false;
  double _editableYAverage = 0;
  bool rYAxisCalibration = false;

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

    bool isPressed = widget.data.b7;

    double normalizedRxAxis = (widget.data.rxAxis - widget.data.rxMin) / (widget.data.rxMax - widget.data.rxMin);
    double clampedNormalizedRxAxis = normalizedRxAxis.clamp(0.0, 1.0);
    double clampedRxAxis = clampedNormalizedRxAxis * 140.0;

    double normalizedRyAxis = (widget.data.ryAxis - widget.data.ryMin) / (widget.data.ryMax - widget.data.ryMin);
    double clampedNormalizedRyAxis = normalizedRyAxis.clamp(0.0, 1.0);
    double clampedRyAxis = clampedNormalizedRyAxis * 140.0;

    return Column(
      children: [
        Stack(
          children: <Widget>[
            Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                color: isPressed ? Color.fromRGBO(99, 6, 6, 1):  Color.fromRGBO(0, 0, 0, 1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color.fromRGBO(99, 6, 6, 1),// Border color
                  width: 2.0,           // Border width
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(193, 10, 10, 1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            
            const Positioned(
              top: 16.0,
              left: 0.0,
              right: 0.0,
              child: Icon(
                size: 15,
                Icons.arrow_upward,
                color: Colors.white54,
              ),
            ),
            const Positioned(
              top: 0.0,
              bottom: 0.0,
              left: 16.0,
              child: Icon(
                size: 15,
                Icons.arrow_back,
                color: Colors.white54,
              ),
            ),
            const Positioned(
              top: 0.0,
              bottom: 0.0,
              right: 16.0,
              child: Icon(
                size: 15,
                Icons.arrow_forward,
                color: Colors.white54,
              ),
            ),
            const Positioned(
              bottom: 16.0,
              left: 0.0,
              right: 0.0,
              child: Icon(
                size: 15,
                Icons.arrow_downward,
                color: Colors.white54,
              ),
            ),
            Positioned(
              top: clampedRyAxis,
              left: clampedRxAxis,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(132, 5, 5, 1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text("Dead zones : X - ${widget.data.rxDeadZone}% Y - ${widget.data.ryDeadZone}%"),
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
              child: Text('Settings sent to device.'),
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
          onPressed: () {
            setState(() {
              _showCalibation = !_showCalibation;
            });

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
                child: Text("X Axis"),
              ),
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
                  if(rXAxisCalibration)
                    Positioned(
                      top: 5,
                      left: (((widget.data.rxAxis - minXValue) / (maxXValue - minXValue)) * 250).clamp(0, 250) - (250 * (deadZoneXChanged ? _editableDeadZoneXValue.toDouble() : widget.data.rxDeadZone.toDouble()) / 100 / 2),
                      child: Container(
                        width: 250 * (deadZoneXChanged ? _editableDeadZoneXValue.toDouble() : widget.data.rxDeadZone.toDouble()) / 100,
                        height: 10,
                        decoration: const BoxDecoration(
                          color:Color.fromRGBO(190, 4, 4, 0.8),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ),
                  if(!rXAxisCalibration)
                    Positioned(
                      top: 5,
                      left: 125 - (250 * (deadZoneXChanged ? _editableDeadZoneXValue.toDouble() : widget.data.rxDeadZone.toDouble()) / 100 / 2),
                      child: Container(
                        width: 250 * (deadZoneXChanged ? _editableDeadZoneXValue.toDouble() : widget.data.rxDeadZone.toDouble()) / 100,
                        height: 10,
                        decoration: const BoxDecoration(
                          color:Color.fromRGBO(190, 4, 4, 0.8),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ),
                  if(rXAxisCalibration)
                    Positioned(
                      top: 0,
                      left: (((widget.data.rxAxis - minXValue) / (maxXValue - minXValue)) * 250).clamp(0, 250) - 10,
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
                    
                ],
              ),
              if(rXAxisCalibration)
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Move left and right  and hold few seconds",
                    textAlign: TextAlign.center,
                  ),
                ),
              if(rXAxisCalibration)
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "to set X axis MIN and MAX values",
                    textAlign: TextAlign.center,
                  ),
                ),
              Padding(
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                    backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                    foregroundColor: Colors.white),
                  child: Text('${rXAxisCalibration ? 'End': 'Start'} calibration'),
                  onPressed: () {
                    setState(() {
                      rXAxisCalibration = !rXAxisCalibration;
                      if(rXAxisCalibration) {
                        minXChanged = true;
                        maxXChanged = true;

                        var valueInXRange = widget.data.rxAxis;
                        minXValue = valueInXRange < minXValue ? valueInXRange : minXValue;
                        maxXValue = valueInXRange > maxXValue ? valueInXRange : maxXValue;

                        _periodicXTimer = Timer.periodic(Duration(milliseconds: 40), (timer) { 
                          var valueInXRange = widget.data.rxAxis;
                          minXValue = valueInXRange < minXValue ? valueInXRange : minXValue;
                          maxXValue = valueInXRange > maxXValue ? valueInXRange : maxXValue;
                        });
                      } else {
                        if (_periodicXTimer.isActive) {
                          _periodicXTimer.cancel();
                        }
                      }
                    });
                  },
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text('Dead zone : ${deadZoneXChanged ? _editableDeadZoneXValue.toInt() : widget.data.rxDeadZone.toInt()}%'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Slider(
                  value: deadZoneXChanged ? _editableDeadZoneXValue : widget.data.rxDeadZone.toDouble(), 
                  min: 0,
                  max: 50,
                  divisions: 50,
                  activeColor:const Color.fromRGBO(193, 10, 10, 1)  ,
                  onChanged: (value) => {
                    setState(() {
                      if(!deadZoneXChanged) {
                        deadZoneXChanged = true;
                      }
                      _editableDeadZoneXValue = value;
                    })
                  }
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text('Averaging: ${averageXChanged ? _editableXAverage.toInt() : widget.data.rxAveraging.toInt()}'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Slider(
                  value: averageXChanged ? _editableXAverage : widget.data.rxAveraging.toDouble(), 
                  min: 0,
                  max: 255,
                  divisions: 255,
                  activeColor:const Color.fromRGBO(193, 10, 10, 1)  ,
                  onChanged: (value) => {
                    setState(() {
                      if(!averageXChanged) {
                        averageXChanged = true;
                      }
                      _editableXAverage = value;
                    })
                  }
                )
              ),
              const Divider(
                color: Color.fromRGBO(41, 41, 41, 1)
              ),
              const Padding(
                padding: EdgeInsets.all(5),
                child: Text("Y Axis"),
              ),
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
                  if(rYAxisCalibration)
                    Positioned(
                      top: 5,
                      left: (((widget.data.ryAxis - minYValue) / (maxYValue - minYValue)) * 250).clamp(0, 250) - (250 * (deadZoneYChanged ? _editableDeadZoneYValue.toDouble() : widget.data.ryDeadZone.toDouble()) / 100 / 2),
                      child: Container(
                        width: 250 * (deadZoneYChanged ? _editableDeadZoneYValue.toDouble() : widget.data.ryDeadZone.toDouble()) / 100,
                        height: 10,
                        decoration: const BoxDecoration(
                          color:Color.fromRGBO(190, 4, 4, 0.8),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ),
                  if(!rYAxisCalibration)
                    Positioned(
                      top: 5,
                      left: 125- (250 * (deadZoneYChanged ? _editableDeadZoneYValue.toDouble() : widget.data.ryDeadZone.toDouble()) / 100 / 2),
                      child: Container(
                        width: 250 * (deadZoneYChanged ? _editableDeadZoneYValue.toDouble() : widget.data.ryDeadZone.toDouble()) / 100,
                        height: 10,
                        decoration: const BoxDecoration(
                          color:Color.fromRGBO(190, 4, 4, 0.8),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ),
                  if(rYAxisCalibration)
                    Positioned(
                      top: 0,
                      left: (((widget.data.ryAxis - minYValue) / (maxYValue - minYValue)) * 250).clamp(0, 250) - 10,
                      child:
                        Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(193, 10, 10, 1),
                          shape: BoxShape.circle,
                          border: Border.all(color: Color.fromRGBO(107, 4, 4, 1))
                          ),
                        ),
                      ),
                    
                ],
              ),
              if(rYAxisCalibration)
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Move up and down and hold few seconds",
                    textAlign: TextAlign.center,
                  ),
                ),
              if(rYAxisCalibration)
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "to set Y axis MIN and MAX values",
                    textAlign: TextAlign.center,
                  ),
                ),
              Padding(
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                    backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                    foregroundColor: Colors.white),
                  child: Text('${rYAxisCalibration ? 'End': 'Start'} calibration',),
                  onPressed: () {
                    setState(() {
                      rYAxisCalibration = !rYAxisCalibration;
                      if(rYAxisCalibration) {
                        minYChanged = true;
                        maxYChanged = true;
                    
                        var valueInYRange = widget.data.ryAxis;
                        minYValue = valueInYRange < minYValue ? valueInYRange : minYValue;
                        maxYValue = valueInYRange > maxYValue ? valueInYRange : maxYValue;

                        _periodicYTimer = Timer.periodic(Duration(milliseconds: 40), (timer) { 
                          var valueInYRange = widget.data.ryAxis;
                          minYValue = valueInYRange < minYValue ? valueInYRange : minYValue;
                          maxYValue = valueInYRange > maxYValue ? valueInYRange : maxYValue;
                        });
                      } else {
                        if (_periodicYTimer.isActive) {
                          _periodicYTimer.cancel();
                        }
                      }
                    });
                  },
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text('Dead zone : ${deadZoneYChanged ? _editableDeadZoneYValue.toInt() : widget.data.ryDeadZone.toInt()}%'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Slider(
                  value: deadZoneYChanged ? _editableDeadZoneYValue : widget.data.ryDeadZone.toDouble(), 
                  min: 0,
                  max: 50,
                  divisions: 50,
                  activeColor:const Color.fromRGBO(193, 10, 10, 1)  ,
                  onChanged: (value) => {
                    setState(() {
                      if(!deadZoneYChanged) {
                        deadZoneYChanged = true;
                      }
                      _editableDeadZoneYValue = value;
                    })
                  }
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text('Averaging: ${averageYChanged ? _editableYAverage.toInt() : widget.data.ryAveraging.toInt()}'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Slider(
                  value: averageYChanged ? _editableYAverage : widget.data.ryAveraging.toDouble(), 
                  min: 0,
                  max: 255,
                  divisions: 255,
                  activeColor:const Color.fromRGBO(193, 10, 10, 1)  ,
                  onChanged: (value) => {
                    setState(() {
                      if(!averageYChanged) {
                        averageYChanged = true;
                      }
                      _editableYAverage = value;
                    })
                  }
                )
              ),
              const Divider(
                color: Color.fromRGBO(41, 41, 41, 1)
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
                      int minXRange = 0;
                      int maxXRange = 0;
                      int averageX = 0;
                      int deadZoneX = 0;

                      if(deadZoneXChanged) {
                        deadZoneX = _editableDeadZoneXValue.toInt();
                        setState(() {
                          deadZoneXChanged = false;
                        });
                      } else {
                        deadZoneX = widget.data.rxDeadZone;
                      }

                      if(averageXChanged) {
                        averageX = _editableXAverage.toInt();
                        setState(() {
                          averageXChanged = false;
                        });
                      } else {
                        averageX = widget.data.rxAveraging;
                      }

                      if(minXChanged) {
                        minXRange = minXValue;
                        setState(() {
                          minXChanged = false;
                        });
                      } else {
                        minXRange = widget.data.rxMin;
                      }

                      if(maxXChanged) {
                        maxXRange = maxXValue;
                        setState(() {
                          maxXChanged = false;
                        });
                      } else {
                        maxXRange = widget.data.rxMax;
                      }

                      rust_request('setrx', minXRange, maxXRange, averageX, deadZoneX, RustOperation.Update);

                      int minYRange = 0;
                      int maxYRange = 0;
                      int averageY = 0;
                      int deadZoneY = 0;

                      if(deadZoneYChanged) {
                        deadZoneY = _editableDeadZoneYValue.toInt();
                        setState(() {
                          deadZoneYChanged = false;
                        });
                      } else {
                        deadZoneY = widget.data.ryDeadZone;
                      }

                      if(averageYChanged) {
                        averageY = _editableYAverage.toInt();
                        setState(() {
                          averageYChanged = false;
                        });
                      } else {
                        averageY = widget.data.ryAveraging;
                      }

                      if(minYChanged) {
                        minYRange = minYValue;
                        setState(() {
                          minYChanged = false;
                        });
                      } else {
                        minYRange = widget.data.ryMin;
                      }

                      if(maxYChanged) {
                        maxYRange = maxYValue;
                        setState(() {
                          maxYChanged = false;
                        });
                      } else {
                        maxYRange = widget.data.ryMax;
                      }

                      rust_request('setry', minYRange, maxYRange, averageY, deadZoneY, RustOperation.Update);
                      rust_request('save', 0, 0, 0, 0, RustOperation.Update);
                      rust_request('apply', 0, 0, 0, 0, RustOperation.Update);

                      _showCalibation = false;
                      rXAxisCalibration = false;
                      rYAxisCalibration = false;

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