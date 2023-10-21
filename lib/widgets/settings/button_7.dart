import 'package:flutter/material.dart';

import 'package:flutter_multi_slider/flutter_multi_slider.dart';
import 'package:flicon/messages/report_message.pb.dart' as reportMessage;
import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:flicon/messages/device_info.pb.dart' as deviceInfo;

class Button7 extends StatefulWidget {
  final reportMessage.ReportMessage data;
  const Button7({Key? key, required this.data}) : super(key: key);

  @override
  State<Button7> createState() => _Button7State();
}

enum buttonType { all, b }

class _Button7State extends State<Button7> {

  buttonType? _currentValue = buttonType.all;
  buttonType? _editableValue = buttonType.all; 
  bool isChanged = false;

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

    String image = 'none';

    if(widget.data.b16 || widget.data.b17 || widget.data.b18) {
      if(widget.data.b16) {
        image = 'push';
      }
      if(widget.data.b17) {
        image = 'top';
      }
      if(widget.data.b18) {
        image = 'bottom';
      }

    } else {
      image = 'none';
    }

    if(widget.data.hatka1Mode == 0) {
      _currentValue = buttonType.all;
    } else if(widget.data.hatka1Mode == 4) {
      _currentValue = buttonType.b;
    }

    return Column(
      children: [
        Stack(
          children: [
            Positioned(
              child: Image.asset('assets/2-axis-button/${image}.png', width: 100, height: 100),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 30, bottom: 10),
          child: Text("Change button type"),
        ),
        ListTile(
          title: Stack(
            children: [
              Positioned(
                child: Image.asset('assets/2-axis-button/vertical.png', width: 35, height: 35),
              ),
              const Positioned(
                left: 45,
                top: 8,
                child: Text("All directions")
              )
            ],
          ),
          leading: Radio<buttonType>(
            value: buttonType.all,
            fillColor: MaterialStateColor.resolveWith((states) => Color.fromRGBO(193, 10, 10, 1)),
            groupValue: isChanged ? _editableValue : _currentValue,
            onChanged: (buttonType? value) {
              setState(() {
                if(!isChanged) {
                  isChanged = true;
                }
                _editableValue = value;
              });
            },
          ),
        ),
      
        ListTile(
          title: Stack(
            children: [
              Positioned(
                child: Image.asset('assets/2-axis-button/push.png', width: 35, height: 35),
              ),
              const Positioned(
                left: 45,
                top: 8,
                child: Text("Push")
              )
            ],
          ),
          leading: Radio<buttonType>(
            value: buttonType.b,
            fillColor: MaterialStateColor.resolveWith((states) => Color.fromRGBO(193, 10, 10, 1)),
            groupValue: isChanged ? _editableValue : _currentValue,
            onChanged: (buttonType? value) {
              setState(() {
                if(!isChanged) {
                  isChanged = true;
                }
                _editableValue = value;
              });
            },
          ),
        ),
        Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero),
              backgroundColor: const Color.fromARGB(255, 62, 62, 62),
              foregroundColor: Colors.white),
          child: const Text('Apply changes'),
          onPressed: isChanged ? () {
            int hatka1 = 0;
            if(_editableValue == buttonType.all) {
              hatka1 = 0;
            } else if (_editableValue == buttonType.b) {    
              hatka1 = 4;
            }

            print(hatka1);
            rust_request('sethatka1', hatka1, 0, 0, 0, RustOperation.Update);
            rust_request('apply', 0, 0, 0, 0, RustOperation.Update);
            rust_request('save', 0, 0, 0, 0, RustOperation.Update);

            setState(() {
              Future.delayed(Duration(seconds: 2)).then((value) {
                isChanged = false;
              });
            });
          } : null,
        )),

       
        
      ]);
    }
}