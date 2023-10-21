import 'package:flutter/material.dart';

import 'package:flutter_multi_slider/flutter_multi_slider.dart';
import 'package:flicon/messages/report_message.pb.dart' as reportMessage;


class Button10 extends StatefulWidget {
  final reportMessage.ReportMessage data;
  const Button10({Key? key, required this.data}) : super(key: key);

  @override
  State<Button10> createState() => _Button10State();
}

enum buttonType { all, hv, h, v, b }

class _Button10State extends State<Button10> {

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
        
      ]);
    }
}