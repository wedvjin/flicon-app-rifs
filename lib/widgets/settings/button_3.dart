import 'package:flutter/material.dart';

import 'package:flutter_multi_slider/flutter_multi_slider.dart';
import 'package:flicon/messages/report_message.pb.dart' as reportMessage;


class Button3 extends StatefulWidget {
  final reportMessage.ReportMessage data;
  const Button3({Key? key, required this.data}) : super(key: key);

  @override
  State<Button3> createState() => _Button3State();
}

enum buttonType { all, hv, h, v, b }

class _Button3State extends State<Button3> {

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
              child: Image.asset('assets/multidirectional_button/none.png', width: 100, height: 100),
            )
          ],
        ),
        Text("${widget.data.encoderTime}"),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text('Encode time: ${_centerPostion.round()}'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Slider(
            value: _centerPostion.toDouble(), 
            min: 0,
            max: 200,
            divisions: 100,
            activeColor:const Color.fromRGBO(193, 10, 10, 1)  ,
            onChanged: (value) => {
              setState(() => _centerPostion = value.toInt())
            }
          )
        ),
        
      ]);
    }
}