import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_multi_slider/flutter_multi_slider.dart';
import 'package:Axium/messages/report_message.pb.dart' as reportMessage;
import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:Axium/messages/device_info.pb.dart' as deviceInfo;


class Gashetka extends StatefulWidget {
  final reportMessage.ReportMessage data;
  const Gashetka({Key? key, required this.data}) : super(key: key);

  @override
  State<Gashetka> createState() => _GashetkaState();
}



class _GashetkaState extends State<Gashetka> {


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

  late Timer _periodicTimer;

  RangeValues trigger1 = RangeValues(-32768, 32768);
  RangeValues trigger2 = RangeValues(-32768, 32768);
  RangeValues trigger3 = RangeValues(-32768, 32768);

  bool trigger1Changed = false;
  bool trigger2Changed = false;
  bool trigger3Changed = false;

  bool callbackMessage = false;

  double _editableDeadZoneValue = 0;
  bool deadZoneChanged = false;
  bool sliderCalibration = false;

  double _editableAverage = 0;
  bool averageChanged = false;


  bool minChanged = false;
  bool maxChanged = false;

  var minValue = 10000000000; 
  var maxValue = -10000000000; 

  RangeValues globalMinMax = RangeValues(-32768, 32768);

  bool _showCalibation = false;



  @override
  Widget build(BuildContext context) {

    double originalProgress = (((widget.data.rz - 0) / (65536 / 2 - 0)) * 300);
    double progress = originalProgress.clamp(0, 300);

    double originalSmallProgress = (((widget.data.rz - 0) / (65536 / 2 - 0)) * 270);
    double progressSmall = originalSmallProgress.clamp(0, 270);

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
                  color: Color.fromRGBO(132, 5, 5, 1),
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
                  color: Color.fromRGBO(193, 10, 10, 1),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: (300 * widget.data.rzDeadZone.toDouble() /100),
                height: 30,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(193, 10, 10, 0),
                  shape: BoxShape.rectangle,
                  border: Border(right: BorderSide(color: Color.fromARGB(255, 41, 41, 41), width: 2.0))
                ),
              ),
            ),
            Positioned(
              top: 45,
              left: 0,
              child: Text(
                  'Dead zone ${widget.data.rzDeadZone.toInt()} %',
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
              
            const Divider(
              color: Color.fromRGBO(41, 41, 41, 1)
            ),
            const Text("Calibration"),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 10), 
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
                        left: (((widget.data.rzAxis - minValue) / (maxValue - minValue)) * 250).clamp(0, 250) - 10,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(193, 10, 10, 1),
                            shape: BoxShape.circle,

                          ),
                        ),
                      ),
                    Positioned(
                      top: 5,
                      left: 0,
                      child: Container(
                        width: deadZoneChanged ? (250 * _editableDeadZoneValue.toDouble() / 100) : (250 * widget.data.rzDeadZone.toDouble() /100),
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
                  
                      var valueInRange = widget.data.rzAxis;
                      minValue = valueInRange < minValue ? valueInRange : minValue;
                      maxValue = valueInRange > maxValue ? valueInRange : maxValue;

                      _periodicTimer = Timer.periodic(Duration(milliseconds: 40), (timer) { 
                        var valueInRange = widget.data.rzAxis;
                        minValue = valueInRange < minValue ? valueInRange : minValue;
                        maxValue = valueInRange > maxValue ? valueInRange : maxValue;

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
              child: Text('Averaging: ${averageChanged ? _editableAverage.toInt() : widget.data.rzAveraging}'),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Slider(
                value: averageChanged ? _editableAverage : widget.data.rzAveraging.toDouble(), 
                min: 1,
                max: 300,
                divisions: 100,
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
                child: Text('Dead zone : ${deadZoneChanged ? _editableDeadZoneValue.toInt() : widget.data.rzDeadZone}%'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Slider(
                  value: deadZoneChanged ? _editableDeadZoneValue : widget.data.rzDeadZone.toDouble(), 
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
            const Divider(
              color: Color.fromRGBO(41, 41, 41, 1)
            ),
            const Text("First trigger range"),
            SliderTheme(
              data: const SliderThemeData(
                thumbColor: Color.fromRGBO(193, 10, 10, 1),
                activeTrackColor: Color.fromRGBO(59, 59, 59, 1),
                inactiveTrackColor: Color.fromRGBO(122, 122, 122, 1),
              ),
              child: 
          
              RangeSlider(
                values: trigger1Changed ? trigger1 : RangeValues(widget.data.gashButton1Min.toDouble(), widget.data.gashButton1Max.toDouble()), 
                min: globalMinMax.start,
                max: globalMinMax.end,
                labels: RangeLabels(
                  trigger1.start.toString(),
                  trigger1.end.toString(), 
                ),
                onChanged: (value) {
                  setState(() {
                    if(!trigger1Changed) {
                      trigger1Changed = true;
                    }

                    trigger1 = value;
                  });
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child:
              Stack(
                children: <Widget>[
                  Container(
                    width: 270,
                    height: 5,
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 270,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(22, 22, 22, 1),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: progressSmall,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(50, 50, 50, 1),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: (270 *  (deadZoneChanged ? _editableDeadZoneValue : widget.data.rzDeadZone.toDouble()) /100),
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(111, 19, 19, 0.685),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                ]
              ),
            ),

            const Divider(
              color: Color.fromRGBO(41, 41, 41, 1)
            ),
            const Text("Second trigger range"),
            SliderTheme(
              data: const SliderThemeData(
                thumbColor: Color.fromRGBO(193, 10, 10, 1),
                activeTrackColor: Color.fromRGBO(59, 59, 59, 1),
                inactiveTrackColor: Color.fromRGBO(122, 122, 122, 1),
                
              ),
              child: 
          
              RangeSlider(
                values: trigger2Changed ? trigger2 : RangeValues(widget.data.gashButton2Min.toDouble(), widget.data.gashButton2Max.toDouble()), 
                min: globalMinMax.start,
                max: globalMinMax.end,
                labels: RangeLabels(
                  trigger2.start.toString(),
                  trigger2.end.toString(), 
                ),
                onChanged: (value) {
                  setState(() {
                    if(!trigger2Changed) {
                      trigger2Changed = true;
                    }
                    trigger2 = value;
                  });
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child:
              Stack(
                children: <Widget>[
                  Container(
                    width: 270,
                    height: 5,
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 270,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(22, 22, 22, 1),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: progressSmall,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(50, 50, 50, 1),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: (270 *  (deadZoneChanged ? _editableDeadZoneValue : widget.data.rzDeadZone.toDouble()) /100),
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(111, 19, 19, 0.685),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                ]
              ),
            ),

            const Divider(
              color: Color.fromRGBO(41, 41, 41, 1)
            ),
            const Text("First trigger range"),
            SliderTheme(
              data: const SliderThemeData(
                thumbColor: Color.fromRGBO(193, 10, 10, 1),
                activeTrackColor: Color.fromRGBO(59, 59, 59, 1),
                inactiveTrackColor: Color.fromRGBO(122, 122, 122, 1),
              ),
              child: 
          
              RangeSlider(
                values: trigger3Changed ? trigger3 : RangeValues(widget.data.gashButton3Min.toDouble(), widget.data.gashButton3Max.toDouble()), 
                min: globalMinMax.start,
                max: globalMinMax.end,
                labels: RangeLabels(
                  trigger3.start.toString(),
                  trigger3.end.toString(), 
                ),
                onChanged: (value) {
                  setState(() {
                    if(!trigger3Changed) {
                      trigger3Changed = true;
                    }
                    trigger3 = value;
                  });
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child:
              Stack(
                children: <Widget>[
                  Container(
                    width: 270,
                    height: 5,
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 270,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(22, 22, 22, 1),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: progressSmall,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(50, 50, 50, 1),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: (270 * (deadZoneChanged ? _editableDeadZoneValue : widget.data.rzDeadZone.toDouble()) /100),
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(111, 19, 19, 0.685),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                ]
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
                  child: const Text('Trigger ranges sent do device.'),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                  foregroundColor: Colors.white),
                child: const Text('Apply changes'),
                onPressed: () {

                  int t1Min = widget.data.gashButton1Min;
                  int t1Max = widget.data.gashButton1Max;

                  if(trigger1Changed) {
                    t1Min = trigger1.start.toInt().round();
                    t1Max = trigger1.end.toInt().round();
                    setState(() {
                      trigger1Changed = false;
                    });
                  }

                  rust_request('setgash1', t1Min, t1Max, 0, 0, RustOperation.Update);

                  int t2Min = widget.data.gashButton2Min;
                  int t2Max = widget.data.gashButton2Max;

                  if(trigger2Changed) {
                    t2Min = trigger2.start.toInt().round();
                    t2Max = trigger2.end.toInt().round();
                    setState(() {
                      trigger2Changed = false;
                    });
                  }

                  rust_request('setgash2', t2Min, t2Max, 0, 0, RustOperation.Update);

                  int t3Min = widget.data.gashButton3Min;
                  int t3Max = widget.data.gashButton3Max;

                  if(trigger3Changed) {
                    t3Min = trigger3.start.toInt().round();
                    t3Max = trigger3.end.toInt().round();
                    setState(() {
                      trigger3Changed = false;
                    });
                  }

                  rust_request('setgash3', t3Min, t3Max, 0, 0, RustOperation.Update);


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
                    deadZone = widget.data.rzDeadZone;
                  }

                  if(averageChanged) {
                    average = _editableAverage.toInt();
                    setState(() {
                      averageChanged = false;
                    });
                  } else {
                    average = widget.data.rzAveraging;
                  }

                  if(minChanged) {
                    minRange = minValue;
                    setState(() {
                      minChanged = false;
                    });
                  } else {
                    minRange = widget.data.rzMin;
                  }

                  if(maxChanged) {
                    maxRange = maxValue;
                    setState(() {
                      maxChanged = false;
                    });
                  } else {
                    maxRange = widget.data.rzMax;
                  }

                  rust_request('setrz', minRange, maxRange, average, deadZone, RustOperation.Update);

                  rust_request('apply', 0, 0, 0, 0, RustOperation.Update);
                  rust_request('save', 0, 0, 0, 0, RustOperation.Update);

                  setState(() {
                    callbackMessage = true;
                    _showCalibation = false;
                    Future.delayed(Duration(seconds: 5)).then((value) {
                      callbackMessage = false;
                    });
                  });
                }
              )
            ),
            ]),

      ]);
    }
}