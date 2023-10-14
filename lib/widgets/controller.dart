import 'package:flicon/models/settings.dart';
import 'package:flicon/models/vars.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'dart:math' as math;
import 'package:toggle_switch/toggle_switch.dart';

class Controllers extends StatefulWidget {
  const Controllers({Key? key}) : super(key: key);

  @override
  State<Controllers> createState() => _ControllersState();
}

class _ControllersState extends State<Controllers> {
  int _showButton = 0;
  int initialController = 1; // right
  bool _showLed = false;
  final secure = Random.secure();
  final int min = 0;
  final int max = 10;
  bool _flip = false;
  
  @override
  Widget build(BuildContext context) {

    var varsRead = context.read<VarsModel>();

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center, 
      children: [
        Positioned(
          child: Transform.flip(
          flipX: _flip,
          child: Image.asset('assets/controllers_and_base.png',
            width: 595, height: 464),
          )
        ),
        Positioned(
          child: Transform.flip(
          flipX: _flip,
          child: Image.asset('assets/btn-${_showButton.toString()}-active.png',
            width: 595, height: 464),
          )
        ),
        if (_showLed)
          Positioned(
            child: Transform.flip(
            flipX: _flip,
            child:
              Image.asset('assets/led-highlight.png', width: 595, height: 464),
            )
          ),
        
        Positioned(
          top: 40,
          child: Text('${varsRead.currentRGB}'),
        ),
        Positioned(
          bottom: 20,
          child: // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
          ToggleSwitch(
            initialLabelIndex: initialController,
            totalSwitches: 2,
            inactiveBgColor: const Color.fromRGBO(44, 44, 44, 1),
            inactiveFgColor: Colors.grey,

            activeBgColor: const [Color.fromRGBO(193, 10, 10, 1), Color.fromRGBO(193, 10, 10, 1)],
            activeFgColor: Colors.white,

            labels: const ['Left', 'Right'],
            onToggle: (index) {
              if(index == 0) {
                setState(() {
                  initialController = index!;
                  _flip = true;
                });
              } else {
                setState(() {
                  initialController = index!;
                  _flip = false;
                });
              }
            },
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            child: FloatingActionButton(
                heroTag: 'rnd',
                key: const Key('rnd'),
                onPressed: () => setState(() {
                      varsRead.remove();
                      if(_showLed) {
                        _showLed = false;
                      }
                      if(_showButton >= 13) {
                        _showButton = 0;
                      } else {
                        _showButton = _showButton + 1;
                      }
                      varsRead.add(Setting(_showButton));
                }),
                child: Text('Button ${_showButton}')
                )),
        Positioned(
            bottom: 60,
            left: 0,
            child: FloatingActionButton(
                heroTag: 'led',
                key: const Key('led'),
                onPressed: () => setState(() {
                      varsRead.remove();
                      _showLed = !_showLed;
                      if(_showLed) {
                        _showButton = 0;
                        varsRead.add(const Setting(9999));
                      }
                  
                    }),
                child: Text('LED ${varsRead.currentRGB.toString()}'))),

    ]);
  }
}