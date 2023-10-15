
import 'package:flicon/widgets/settings/base_calibration.dart';
import 'package:flicon/widgets/settings/base_rotation.dart';
import 'package:flicon/widgets/settings/led_color_picker.dart';
import 'package:flutter/material.dart';

import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:flicon/messages/report_message.pb.dart' as reportMessage;
import 'package:toggle_switch/toggle_switch.dart';


const List<String> profiles = <String>[
  'Profile 1',
  'Profile 2',
  'Profile 3',
  'Profile 4'
];

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  String profileListValue = profiles.first;
  HSVColor color = HSVColor.fromColor(Colors.blue);
  int _showButton = 0;
  var cursor = SystemMouseCursors.basic;
  int initialController = 1; // right
  bool _showLed = false;
  final int min = 0;
  final int max = 10;
  bool _flip = false;


  double x = 0.0;
  double y = 0.0;


  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;

      if(((x > 97 && y > 161) && (x<129 && y<193)) || ((x>547 && y>166) && (x<574 && y<198))) {
        _showButton = 8;
      } else if(((x >535 && y > 389) && (x<556 && y<413))) {
        _showButton = 1;
      } else if(((x > 78 && y > 273) && (x<105 && y<285)) || ((x>563 && y>276) && (x<593 && y<300))) {
        _showButton = 3;
      } else if(((x >243 && y > 168) && (x<268 && y<240))) {
        _showButton = 4;
      } else if(((x >152 && y > 222) && (x<163 && y<238))) {
        _showButton = 5;
      } else if(((x > 193 && y > 269) && (x<200 && y<307)) || ((x>460 && y>286) && (x<502 && y<316))) {
        _showButton = 6;
      } else if(((x > 100 && y > 499) && (x<169 && y<539)) || ((x>518 && y>469) && (x<579 && y<505))) {
        _showButton = 7;
      } else if(((x > 215 && y > 271) && (x<252 && y<317)) || ((x>402 && y>309) && (x<434 && y<345))) {
        _showButton = 9;
      } else if(((x > 188 && y > 348) && (x<222 && y<435)) || ((x>429 && y>370) && (x<484 && y<454))) {
        _showButton = 10;
      } else if(((x >136 && y > 176) && (x<162 && y<207))) {
        _showButton = 11;
      } else if(((x >183 && y > 139) && (x<208 && y<170))) {
        _showButton = 12;
      } else if(((x >313 && y > 401) && (x<352 && y<435))) {
        _showButton = 13;
      } else if(((x >153 && y > 143) && (x<171 && y<166))) {
        _showButton = 2;
      } else if(((x >385 && y > 270) && (x<455 && y<297))) {
        _showButton = 898;
      } else {
        _showButton = 0;
        cursor = SystemMouseCursors.basic;
      }

      if(_showButton != 0) {
        cursor = SystemMouseCursors.click;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: StreamBuilder<RustSignal>(
            stream: rustBroadcaster.stream.where((rustSignal) {
              return rustSignal.resource == reportMessage.ID;
            }),
            builder: (context, snapshot) {
              final rustSignal = snapshot.data;
              if (rustSignal == null) {
                return Text("No reportInMessage stream");
              } else {
                var data = reportMessage.ReportMessage.fromBuffer(rustSignal.message as List<int>);
              
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center, 
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Colors.black12,
                              Colors.black,
                            ],
                          )
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: MouseRegion(
                            onHover: _updateLocation,
                            cursor: cursor,
                            child: Stack(
                                key: Key("11"),
                                fit: StackFit.expand,
                                alignment: Alignment.center, 
                                children: [
                                  if(_flip) 
                                    Positioned(
                                      child: Image.asset('assets/controller-flipped.png', width: 595, height: 464),
                                    ),
                                  if(!_flip) 
                                    Positioned(
                                      child: Image.asset('assets/controllers_and_base.png', width: 595, height: 464),
                                    ),
                                  Positioned(
                                    child: Image.asset('assets/btn-${_showButton.toString()}-active.png', width: 595, height: 464),
                                  ),
                                  Positioned(
                                    top: 40,
                                    child: Text('${data.buttons}'),
                                  ),
                                  Positioned(top: 20,child: Text('$x $y')),
                                  Positioned(
                                    bottom: 20,
                                    child: // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
                                      ToggleSwitch(
                                        initialLabelIndex: initialController,
                                        totalSwitches: 2,
                                        inactiveBgColor: Color.fromRGBO(44, 44, 44, 1),
                                        inactiveFgColor: Colors.grey,

                                        activeBgColor: [Color.fromRGBO(193, 10, 10, 1), Color.fromRGBO(193, 10, 10, 1)],
                                        activeFgColor: Colors.white,

                                        labels: ['Left', 'Right'],
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

                                ]
                              )
                            
                          )
                        )
                      )
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.black,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                          child: ListView(
                            children: [
                              Text("${_showButton}"),
                              Column(children: [
                                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: DropdownMenu<String>(
                                          enableFilter: false,
                                          enableSearch: false,
                                          width: 315,
                                          label: const Text("Profile"),
                                          leadingIcon: const Icon(Icons.folder),
                                          inputDecorationTheme: const InputDecorationTheme(
                                            filled: true,
                                            fillColor: Colors.black,
                                            outlineBorder: BorderSide(color: Color.fromRGBO(193, 10, 10, 1)),
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                          ),
                                          onSelected: (String? value) {
                                            // This is called when the user selects an item.
                                            setState(() {
                                              profileListValue = value!;
                                            });
                                          },
                                          dropdownMenuEntries:
                                              profiles.map<DropdownMenuEntry<String>>((String value) {
                                            return DropdownMenuEntry<String>(value: value, label: value);
                                          }).toList(),
                                        ),
                                      ))
                                ]),
                                Row(children: [
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(right: 2),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero),
                                          backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                                          foregroundColor: Colors.white),
                                      child: const Text('Load'),
                                      onPressed: () => {},
                                    ),
                                  )),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero),
                                            backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                                            foregroundColor: Colors.white),
                                        child: const Text('Save'),
                                        onPressed: () => {},
                                      ),
                                    ),
                                  )
                                ]),
                                const Divider(
                                  height: 30,
                                  thickness: 5,
                                  indent: 20,
                                  endIndent: 0,
                                  color: Colors.black12,
                                ),
                                //if(_showButton == 7)
                                BaseRotation(data: data),
                                if(_showButton == 13)
                                  JoystickCalibartion(data: data),
                                if(_showButton == 898)
                                  const LedColorPicker()
                              ])
                            ],
                          )
                        )
                      )
                    ),
                  ]
                );
              }
            }
          )
        ),
      );
  }
}