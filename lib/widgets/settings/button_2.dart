import 'package:flutter/material.dart';

import 'package:flutter_multi_slider/flutter_multi_slider.dart';
import 'package:flicon/messages/report_message.pb.dart' as reportMessage;
import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:flicon/messages/device_info.pb.dart' as deviceInfo;

class Button2 extends StatefulWidget {
  final reportMessage.ReportMessage data;
  const Button2({Key? key, required this.data}) : super(key: key);

  @override
  State<Button2> createState() => _Button2State();
}

enum buttonType { all, hv, h, v, b }

class _Button2State extends State<Button2> {

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

    if(widget.data.b37 || widget.data.b38 || widget.data.b39 || widget.data.b40 || widget.data.b41 || widget.data.b42 || widget.data.b43 || widget.data.b44 || widget.data.b45) {
      if(widget.data.b37) {
        image = 'push';
      }
      if(widget.data.b38) {
        image = 'top';
      }
      if(widget.data.b39) {
        image = 'right-top';
      }
      if(widget.data.b40) {
        image = 'right';
      }
      if(widget.data.b41) {
        image = 'right-bottom';
      }
      if(widget.data.b42) {
        image = 'bottom';
      }
      if(widget.data.b43) {
        image = 'left-bottom';
      }
      if(widget.data.b44) {
        image = 'left';
      }
      if(widget.data.b45) {
        image = 'left-top';
      }
    } else {
      image = 'none';
    }

    if(widget.data.hatka4Mode == 0) {
      _currentValue = buttonType.all;
    } else if(widget.data.hatka4Mode == 1) {
      _currentValue = buttonType.hv;
    } else if(widget.data.hatka4Mode == 2) {
      _currentValue = buttonType.h;
    } else if(widget.data.hatka4Mode == 3) {
      _currentValue = buttonType.v;
    } else if(widget.data.hatka4Mode == 4) {
      _currentValue = buttonType.b;
    }


    return Column(
      children: [
        Stack(
          children: [
            Positioned(
              child: Image.asset('assets/multidirectional_button/${image}.png', width: 100, height: 100),
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
                child: Image.asset('assets/multidirectional_button/all.png', width: 35, height: 35),
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
                child: Image.asset('assets/multidirectional_button/horizontal-vertical.png', width: 35, height: 35),
              ),
              const Positioned(
                left: 45,
                top: 8,
                child: Text("Horizonal & vertical")
              )
            ],
          ),
          leading: Radio<buttonType>(
            value: buttonType.hv,
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
                child: Image.asset('assets/multidirectional_button/horizontal.png', width: 35, height: 35),
              ),
              const Positioned(
                left: 45,
                top: 8,
                child: Text("Horizonal")
              )
            ],
          ),
          leading: Radio<buttonType>(
            value: buttonType.h,
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
                child: Image.asset('assets/multidirectional_button/vertical.png', width: 35, height: 35),
              ),
              const Positioned(
                left: 45,
                top: 8,
                child: Text("Vertical")
              )
            ],
          ),
          leading: Radio<buttonType>(
            value: buttonType.v,
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
                child: Image.asset('assets/multidirectional_button/push.png', width: 35, height: 35),
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
            int hatka4 = 0;
            if(_editableValue == buttonType.all) {
              hatka4 = 0;
            } else if (_editableValue == buttonType.hv) {
              hatka4 = 1;
            } else if (_editableValue == buttonType.h) {
              hatka4 = 2;
            } else if (_editableValue == buttonType.v) {  
              hatka4 = 3;
            } else if (_editableValue == buttonType.b) {    
              hatka4 = 4;
            }
            rust_request('sethatka4', hatka4, 0, 0, 0, RustOperation.Update);
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