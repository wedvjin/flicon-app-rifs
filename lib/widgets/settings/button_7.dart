import 'package:flutter/material.dart';

import 'package:flutter_multi_slider/flutter_multi_slider.dart';
import 'package:flicon/messages/report_message.pb.dart' as reportMessage;


class Button7 extends StatefulWidget {
  final reportMessage.ReportMessage data;
  const Button7({Key? key, required this.data}) : super(key: key);

  @override
  State<Button7> createState() => _Button7State();
}

enum buttonType { all, b }

class _Button7State extends State<Button7> {

  int _centerPostion = 50;

  bool _showCalibation = false;

  List<double> calibration = [5, 45, 65, 95];
  buttonType? _character = buttonType.all;


  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        Stack(
          children: [
            Positioned(
              child: Image.asset('assets/2-axis-button/none.png', width: 100, height: 100),
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
            groupValue: _character,
            onChanged: (buttonType? value) {
              setState(() {
                _character = value;
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
            groupValue: _character,
            fillColor: MaterialStateColor.resolveWith((states) => Color.fromRGBO(193, 10, 10, 1)),
            onChanged: (buttonType? value) {
              setState(() {
                _character = value;
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
          onPressed: () => {
            setState(() => _showCalibation = !_showCalibation)
        
          },
        )),

       
        
      ]);
    }
}