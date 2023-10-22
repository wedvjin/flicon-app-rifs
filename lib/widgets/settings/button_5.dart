import 'package:flutter/material.dart';

import 'package:flutter_multi_slider/flutter_multi_slider.dart';
import 'package:Axium/messages/report_message.pb.dart' as reportMessage;
import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:Axium/messages/device_info.pb.dart' as deviceInfo;


class Button5 extends StatefulWidget {
  final reportMessage.ReportMessage data;
  const Button5({Key? key, required this.data}) : super(key: key);

  @override
  State<Button5> createState() => _Button5State();
}

enum buttonType { all, hv, h, v, b }

class _Button5State extends State<Button5> {


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

    if(widget.data.b28 || widget.data.b29 || widget.data.b30 || widget.data.b31 || widget.data.b32 || widget.data.b33 || widget.data.b34 || widget.data.b34 || widget.data.b35 || widget.data.b36) {
      if(widget.data.b28) {
        image = 'push';
      }
      if(widget.data.b29) {
        image = 'top';
      }
      if(widget.data.b30) {
        image = 'right-top';
      }
      if(widget.data.b31) {
        image = 'right';
      }
      if(widget.data.b32) {
        image = 'right-bottom';
      }
      if(widget.data.b33) {
        image = 'bottom';
      }
      if(widget.data.b34) {
        image = 'left-bottom';
      }
      if(widget.data.b35) {
        image = 'left';
      }
      if(widget.data.b36) {
        image = 'left-top';
      }
    } else {
      image = 'none';
    }

    if(widget.data.hatka3Mode == 0) {
      _currentValue = buttonType.all;
    } else if(widget.data.hatka3Mode == 1) {
      _currentValue = buttonType.hv;
    } else if(widget.data.hatka3Mode == 2) {
      _currentValue = buttonType.h;
    } else if(widget.data.hatka3Mode == 3) {
      _currentValue = buttonType.v;
    } else if(widget.data.hatka3Mode == 4) {
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
            int hatka3 = 0;
            if(_editableValue == buttonType.all) {
              hatka3 = 0;
            } else if (_editableValue == buttonType.hv) {
              hatka3 = 1;
            } else if (_editableValue == buttonType.h) {
              hatka3 = 2;
            } else if (_editableValue == buttonType.v) {  
              hatka3 = 3;
            } else if (_editableValue == buttonType.b) {    
              hatka3 = 4;
            }
            rust_request('sethatka3', hatka3, 0, 0, 0, RustOperation.Update);
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