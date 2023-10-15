import 'package:flutter/material.dart';

import 'package:flutter_multi_slider/flutter_multi_slider.dart';
import 'package:flicon/messages/report_message.pb.dart' as reportMessage;


class Button8 extends StatefulWidget {
  final reportMessage.ReportMessage data;
  const Button8({Key? key, required this.data}) : super(key: key);

  @override
  State<Button8> createState() => _Button8State();
}

class _Button8State extends State<Button8> {

  int _centerPostion = 50;

  bool _showCalibation = false;

  List<double> calibration = [5, 45, 65, 95];

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Stack(
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(193, 10, 10, 1),
                shape: BoxShape.circle,
              ),
            ),
            
            const Positioned(
              top: 16.0,
              left: 0.0,
              right: 0.0,
              child: Icon(
                Icons.arrow_upward,
                color: Colors.white54,
              ),
            ),
            const Positioned(
              top: 0.0,
              bottom: 0.0,
              left: 16.0,
              child: Icon(
                Icons.arrow_back,
                color: Colors.white54,
              ),
            ),
            const Positioned(
              top: 0.0,
              bottom: 0.0,
              right: 16.0,
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white54,
              ),
            ),
            const Positioned(
              bottom: 16.0,
              left: 0.0,
              right: 0.0,
              child: Icon(
                Icons.arrow_downward,
                color: Colors.white54,
              ),
            ),
            Positioned(
              bottom: 150 / 2 - 15 + (((widget.data.ry * 100 / widget.data.ryMax) - 50)),
              left: 150 / 2 - 15 + (((widget.data.rx * 100 / widget.data.rxMax) - 50)),
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
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero),
              backgroundColor: const Color.fromARGB(255, 62, 62, 62),
              foregroundColor: Colors.white),
          child: const Text('Calibrate'),
          onPressed: () => {
            setState(() => _showCalibation = !_showCalibation)
        
          },
        )),
        Text("${widget.data.rx} ${widget.data.rxMax} ${widget.data.rxMin}"),
        Text("${widget.data.ry} ${widget.data.ryMax} ${widget.data.ryMin}"),
        if(_showCalibation) 
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20) , 
                child: MultiSlider(
                  min: 1,
                  max: 100,
                  height: 50,
                  horizontalPadding: 50,
                  activeTrackSize: 2,
                  inactiveTrackSize: 2,
                  textHeightOffset: -20,
                  thumbRadius: 10,
                  values: calibration,
                  thumbColor: const Color.fromRGBO(193, 10, 10, 1),
                  color: const Color.fromRGBO(193, 10, 10, 1),
                  textDirection: TextDirection.rtl,
                  onChanged: (value) => {
                    setState(() => calibration = value)
                  },
                  divisions: 48,
                )
              ),
              Text('Center average : ${_centerPostion}'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: Slider(
                  value: _centerPostion.toDouble(), 
                  min: 1,
                  max: 100,
                  divisions: 100,
                  activeColor:const Color.fromRGBO(193, 10, 10, 1)  ,
                  onChanged: (value) => {
                    setState(() => _centerPostion = value.round())
                  }
                )
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                    foregroundColor: Colors.white),
                child: const Text('Apply & Save'),
                onPressed: () => {
                  setState(() => _showCalibation = !_showCalibation)
              
                },
              ),
            ]
          )

        
      ]);
    }
}