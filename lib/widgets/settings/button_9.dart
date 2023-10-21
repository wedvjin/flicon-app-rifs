import 'package:flutter/material.dart';

import 'package:flutter_multi_slider/flutter_multi_slider.dart';
import 'package:flicon/messages/report_message.pb.dart' as reportMessage;


class Button9 extends StatefulWidget {
  final reportMessage.ReportMessage data;
  const Button9({Key? key, required this.data}) : super(key: key);

  @override
  State<Button9> createState() => _Button9State();
}

class _Button9State extends State<Button9> {

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
              width: 250,
              height: 30,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(193, 10, 10, 1),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: (widget.data.slider * 250 / 23000 ).toDouble(),
                height: 30,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(132, 5, 5, 1),
                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),

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

        Text("${widget.data.slider} ${widget.data.sliderAveraging} ${widget.data.sliderMin} ${widget.data.sliderMax}"),
  
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
              Text('Center average : $_centerPostion'),
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