import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_multi_slider/flutter_multi_slider.dart';
import 'package:flicon/messages/report_message.pb.dart' as reportMessage;

class BaseRotation extends StatefulWidget {
  final reportMessage.ReportMessage data;

  const BaseRotation({Key? key, required this.data}) : super(key: key);

  @override
  State<BaseRotation> createState() => _BaseRotationState();
}

class _BaseRotationState extends State<BaseRotation> {

  double _rotationValue = 0.0;
  double _realRotationValue = 0.0;
  
  double _centerPostion = 0.0;

  bool _showCalibation = false;

  List<double> calibration = [0, 0.05, 0.05, 0.1];
  double _radiusValue = 0.0;
  bool _negativeValue = false;

  @override
  Widget build(BuildContext context) {

    double rotationAngle = (widget.data.z * 100 /widget.data.zMin) - 50;

    
    return Column(
      children: [
        Transform.rotate(
          angle: _centerPostion,
          child: Stack(
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(193, 10, 10, 1),
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                top: 10.0,
                bottom: 10.0,
                left: 10.0,
                child: SizedBox(
                  width: 130,
                  height: 130,
                  child: Transform.flip(
                    flipX: (rotationAngle - 0.5) < 0,
                    child: CircularProgressIndicator(
                      value: (rotationAngle / 100).abs(),
                      strokeWidth: 20.0,
                      valueColor : const AlwaysStoppedAnimation(Color.fromRGBO(132, 5, 5, 1))
                    )
                  )
                ),
              ),
              Positioned(
                top: 10.0,
                bottom: 10.0,
                left: 10.0,
                child: SizedBox(
                  width: 130,
                  height: 130,
                  child: Transform.flip(
                    flipX: _negativeValue,
                    child: CircularProgressIndicator(
                      value: widget.data.zDeadZone / 100 / 2,
                      strokeWidth: 20.0,
                      valueColor : const AlwaysStoppedAnimation(Color.fromRGBO(59, 1, 1, 1))
                    )
                  )
                ),
              ),
              Positioned(
                top: 10.0,
                bottom: 10.0,
                left: 10.0,
                child: SizedBox(
                  width: 130,
                  height: 130,
                  child: Transform.flip(
                    flipX: !_negativeValue,
                    child: CircularProgressIndicator(
                      value: widget.data.zDeadZone / 100 / 2,
                      strokeWidth: 20.0,
                      valueColor : const AlwaysStoppedAnimation(Color.fromRGBO(59, 1, 1, 1))
                    )
                  )
                ),
              ),
          
               Positioned(
                top: 0,
                left: 0,
                child: SizedBox(
                  width: 150,
                  height: 20,
                  child: Center(
                    child: 
                    Text(
                      "${widget.data.zDeadZone} %", 
                      style: const TextStyle(fontSize: 10),
                    )
                  ),
                )
              ),
              Positioned(
                top: 150 / 2 - 35,
                left: 150 / 2 - 35,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(132, 5, 5, 1),
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          ),
        ),
        
        // const Text('Rotation'),
        // Text("${widget.data.z} (min: ${widget.data.zMin} max: ${widget.data.zMax})"),
        // Text("Dead zone: ${widget.data.zDeadZone}, center: ${widget.data.zCentr}, avg: ${widget.data.zAveraging}"),
        // Text("_roration : ${(widget.data.z * 100 /widget.data.zMin) - 50}"),
        // Text("rotationAngle: ${rotationAngle / 100}"),
        // Text("flip : ${(rotationAngle - 0.5) < 0}"),
        // Slider(
        //   value: _rotationValue,
        //   min: -0.35,
        //   max: 0.35,
        //   divisions: 100,
        //   label: _rotationValue.toString(),
        //   onChanged: (double value) {
        //     setState(() {
        //       _rotationValue = value;
        //       if(value < 0) {
        //         _negativeValue = true;
        //         _realRotationValue = value.abs();
        //       } else {
        //         _negativeValue = false;
        //         _realRotationValue = value;
        //       }
            
        //     });
        //   },
        // ),
      
        
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
        if(_showCalibation) 
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20) , 
                child: MultiSlider(
                  min: 0.00,
                  max: 0.1,
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
                    setState(() {
                      calibration = value;
                    })
                  },
                  divisions: 48,
                )
              ),
              Text('Center average : ${(_centerPostion * 100).round()}'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: Slider(
                  value: _centerPostion.toDouble(), 
                  min: -1,
                  max: 1,
                  divisions: 100,
                  activeColor:const Color.fromRGBO(193, 10, 10, 1)  ,
                  onChanged: (value) => {
                    setState(() => _centerPostion = value)
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