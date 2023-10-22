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

  RangeValues globalMinMax = RangeValues(0, 10000);

  RangeValues trigger1 = RangeValues(0, 7000);
  RangeValues trigger2 = RangeValues(0, 7000);
  RangeValues trigger3 = RangeValues(0, 7000);

  bool trigger1Changed = false;
  bool trigger2Changed = false;
  bool trigger3Changed = false;

  bool callbackMessage = false;



  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        const Divider(
          color: Color.fromRGBO(41, 41, 41, 1)
        ),
        const Text("First trigger range"),
        SliderTheme(
          data: const SliderThemeData(
            thumbColor: Color.fromRGBO(193, 10, 10, 1),
            activeTrackColor: Color.fromRGBO(13, 193, 10, 1),
            inactiveTrackColor: Color.fromRGBO(193, 10, 10, 1),
            
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

        const Divider(
          color: Color.fromRGBO(41, 41, 41, 1)
        ),
        const Text("Second trigger range"),
        SliderTheme(
          data: const SliderThemeData(
            thumbColor: Color.fromRGBO(193, 10, 10, 1),
            activeTrackColor: Color.fromRGBO(13, 193, 10, 1),
            inactiveTrackColor: Color.fromRGBO(193, 10, 10, 1),
            
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

        const Divider(
          color: Color.fromRGBO(41, 41, 41, 1)
        ),
        const Text("First trigger range"),
        SliderTheme(
          data: const SliderThemeData(
            thumbColor: Color.fromRGBO(193, 10, 10, 1),
            activeTrackColor: Color.fromRGBO(13, 193, 10, 1),
            inactiveTrackColor: Color.fromRGBO(193, 10, 10, 1),
            
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

              rust_request('apply', 0, 0, 0, 0, RustOperation.Update);
              rust_request('save', 0, 0, 0, 0, RustOperation.Update);

              setState(() {
                callbackMessage = true;
                Future.delayed(Duration(seconds: 5)).then((value) {
                  callbackMessage = false;
                });
              });
            }
          )
        ),

      ]);
    }
}