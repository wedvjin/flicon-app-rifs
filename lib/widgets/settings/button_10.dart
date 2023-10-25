import 'package:flutter/material.dart';

import 'package:flutter_multi_slider/flutter_multi_slider.dart';
import 'package:Axium/messages/report_message.pb.dart' as reportMessage;
import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:Axium/messages/device_info.pb.dart' as deviceInfo;

class Button10 extends StatefulWidget {
  final reportMessage.ReportMessage data;
  const Button10({Key? key, required this.data}) : super(key: key);

  @override
  State<Button10> createState() => _Button10State();
}

enum buttonType { all, hv, h, v, b }

class _Button10State extends State<Button10> {

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

    if(widget.data.b19 || widget.data.b20 || widget.data.b21 || widget.data.b22 || widget.data.b23 || widget.data.b24 || widget.data.b25 || widget.data.b26 || widget.data.b27) {
      if(widget.data.b19) {
        image = 'push';
      }
      if(widget.data.b20) {
        image = 'top';
      }
      if(widget.data.b21) {
        image = 'right-top';
      }
      if(widget.data.b22) {
        image = 'right';
      }
      if(widget.data.b23) {
        image = 'right-bottom';
      }
      if(widget.data.b24) {
        image = 'bottom';
      }
      if(widget.data.b25) {
        image = 'left-bottom';
      }
      if(widget.data.b26) {
        image = 'left';
      }
      if(widget.data.b27) {
        image = 'left-top';
      }
    } else {
      image = 'none';
    }

    if(widget.data.hatka2Mode == 0) {
      _currentValue = buttonType.all;
    } else if(widget.data.hatka2Mode == 1) {
      _currentValue = buttonType.hv;
    } else if(widget.data.hatka2Mode == 2) {
      _currentValue = buttonType.h;
    } else if(widget.data.hatka2Mode == 3) {
      _currentValue = buttonType.v;
    } else if(widget.data.hatka2Mode == 4) {
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
            int hatka2 = 0;
            if(_editableValue == buttonType.all) {
              hatka2 = 0;
            } else if (_editableValue == buttonType.hv) {
              hatka2 = 1;
            } else if (_editableValue == buttonType.h) {
              hatka2 = 2;
            } else if (_editableValue == buttonType.v) {  
              hatka2 = 3;
            } else if (_editableValue == buttonType.b) {    
              hatka2 = 4;
            }
            rust_request('sethatka2', hatka2, 0, 0, 0, RustOperation.Update);
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