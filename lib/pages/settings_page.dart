

import 'dart:ffi';
import 'dart:typed_data';

import 'package:blur/blur.dart';
import 'package:flicon/pages/search_page.dart';
import 'package:flicon/widgets/settings/base_calibration.dart';
import 'package:flicon/widgets/settings/base_rotation.dart';
import 'package:flicon/widgets/settings/button_1.dart';
import 'package:flicon/widgets/settings/button_10.dart';
import 'package:flicon/widgets/settings/button_2.dart';
import 'package:flicon/widgets/settings/button_3.dart';
import 'package:flicon/widgets/settings/button_5.dart';
import 'package:flicon/widgets/settings/button_7.dart';
import 'package:flicon/widgets/settings/button_9.dart';
import 'package:flicon/widgets/settings/led_color_picker.dart';
import 'package:flutter/material.dart';

import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:flicon/messages/report_message.pb.dart' as reportMessage;
import 'package:toggle_switch/toggle_switch.dart';
import 'package:keyboard_mouse_indicator/keyboard_mouse_indicator.dart';


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

  late final KeyboardIndicatorController mouseController = KeyboardIndicatorController();
  Offset? _tapPosition;

  String profileListValue = profiles.first;
  HSVColor color = HSVColor.fromColor(Colors.blue);
  int _showButton = 0;
  List<int> _showButtons = [0];
  int _controlButton = 0;
  var cursor = SystemMouseCursors.basic;
  int initialController = 1; // right
  String controller = 'right';
  final int min = 0;
  final int max = 10;
  final bool _flip = false;

  double realX = 0;
  double realY = 0;

  void setControlButton(int buttonID) {
    setState(() {
      if(_controlButton == buttonID) {
        _controlButton = 0;
      } else {
        _controlButton = buttonID;
      }
    });
  }

  void clickPostion(TapDownDetails details) async {
    setState(() {
      double x = details.globalPosition.dx;
      double y = details.globalPosition.dy;

      if(controller == 'right') {
        if(((x > 97 && y > 161) && (x<129 && y<193)) || ((x>547 && y>166) && (x<574 && y<198))) {
          setControlButton(1);
        } else if(((x >136 && y > 176) && (x<162 && y<207))) {
          setControlButton(2);
        } else if(((x >152 && y > 222) && (x<163 && y<238))) {
          setControlButton(3);
        } else if(((x >175 && y > 186) && (x<197 && y<206))) {
          setControlButton(4);
        } else if(((x >183 && y > 139) && (x<208 && y<170))) {
          setControlButton(5);
        } else if(((x >153 && y > 143) && (x<171 && y<166))) {
          setControlButton(6);
        } else if(((x >243 && y > 168) && (x<268 && y<240))) {
          setControlButton(7);
        } else if(((x >535 && y > 389) && (x<556 && y<413))) {
          setControlButton(8);
        } else if(((x > 188 && y > 348) && (x<222 && y<435)) || ((x>429 && y>370) && (x<484 && y<454))) {
          setControlButton(9);
        } else if(((x > 78 && y > 273) && (x<105 && y<285)) || ((x>563 && y>276) && (x<593 && y<300))) {
          setControlButton(10);
        } else if(((x > 191 && y > 269) && (x<209 && y<307)) || ((x>460 && y>286) && (x<502 && y<316))) {
          setControlButton(11);
        } else if(((x > 215 && y > 271) && (x<252 && y<317)) || ((x>402 && y>309) && (x<434 && y<345))) {
          setControlButton(12);
        } else if(((x >291 && y > 404) && (x<372 && y<472))) {
          setControlButton(13);
        } else if(((x > 100 && y > 499) && (x<169 && y<539)) || ((x>518 && y>469) && (x<579 && y<505))) {
          setControlButton(14);
        } else if(((x >385 && y > 270) && (x<455 && y<297))) {
          setControlButton(898);
        } else {
          setControlButton(0);
        }
      }

      if(controller == 'left') {
        if(((x > 199 && y > 173) && (x<229 && y<205)) || ((x>448 && y>175) && (x<476 && y<202))) {
          setControlButton(1);
        } else if(((x >484 && y > 190) && (x<509 && y<215))) {
          setControlButton(2);
        } else if(((x >499 && y > 230) && (x<510 && y<247))) {
          setControlButton(3);
        } else if(((x >520 && y > 196) && (x<528 && y<218))) {
          setControlButton(4);
        } else if(((x >527 && y > 156) && (x<549 && y<183))) {
          setControlButton(5);
        } else if(((x >498 && y > 159) && (x<515 && y<179))) {
          setControlButton(6);
        } else if(((x >581 && y > 179) && (x<603 && y<249))) {
          setControlButton(7);
        } else if(((x >184 && y > 413) && (x<210 && y<441))) {
          setControlButton(8);
        } else if(((x > 70 && y > 391) && (x<143 && y<494)) || ((x>526 && y>341) && (x<562 && y<426))) {
          setControlButton(9);
        } else if(((x > 215 && y > 290) && (x<251 && y<317)) || ((x>433 && y>275) && (x<455 && y<286))) {
          setControlButton(10);
        } else if(((x > 101 && y > 296) && (x<156 && y<330)) || ((x>536 && y>271) && (x<546 && y<306))) {
          setControlButton(11);
        } else if(((x > 37 && y > 326) && (x<78 && y<366)) || ((x>554 && y>274) && (x<590 && y<317))) {
          setControlButton(12);
        } else if(((x >291 && y > 404) && (x<372 && y<472))) {
          setControlButton(13);
        } else if(((x >165 && y > 499) && (x<234 && y<536)) || ((x>454 && y>481) && (x<514 && y< 517))) {
          setControlButton(14);
        } else if(((x >26 && y > 292) && (x<97 && y<313))) {
          setControlButton(898);
        } else {
          setControlButton(0);
        }
      }
    });
  }


  void _updateLocation(PointerEvent details) {
    setState(() {
      double x = details.position.dx;
      double y = details.position.dy;

      realX = details.position.dx;
      realY = details.position.dy;

      if(controller == 'right') {
        if(((x > 97 && y > 161) && (x<129 && y<193)) || ((x>547 && y>166) && (x<574 && y<198))) {
          _showButton = 1;
        } else if(((x >136 && y > 176) && (x<162 && y<207))) {
          _showButton = 2;
        } else if(((x >152 && y > 222) && (x<163 && y<238))) {
          _showButton = 3;
        } else if(((x >175 && y > 186) && (x<197 && y<206))) {
          _showButton = 4;
        } else if(((x >183 && y > 139) && (x<208 && y<170))) {
          _showButton = 5;
        } else if(((x >153 && y > 143) && (x<171 && y<166))) {
          _showButton = 6;
        } else if(((x >243 && y > 168) && (x<268 && y<240))) {
          _showButton = 7;
        } else if(((x >535 && y > 389) && (x<556 && y<413))) {
          _showButton = 8;
        } else if(((x > 188 && y > 348) && (x<222 && y<435)) || ((x>429 && y>370) && (x<484 && y<454))) {
          _showButton = 9;
        } else if(((x > 78 && y > 273) && (x<105 && y<285)) || ((x>563 && y>276) && (x<593 && y<300))) {
          _showButton = 10;
        } else if(((x > 191 && y > 269) && (x<209 && y<307)) || ((x>460 && y>286) && (x<502 && y<316))) {
          _showButton = 11;
        } else if(((x > 215 && y > 271) && (x<252 && y<317)) || ((x>402 && y>309) && (x<434 && y<345))) {
          _showButton = 12;
        } else if(((x >291 && y > 404) && (x<372 && y<472))) {
          _showButton = 13;
        } else if(((x > 100 && y > 499) && (x<169 && y<539)) || ((x>518 && y>469) && (x<579 && y<505))) {
          _showButton = 14;
        } else if(((x >385 && y > 270) && (x<455 && y<297))) {
          _showButton = 898;
        } else {
          _showButton = 0;
          cursor = SystemMouseCursors.basic;
        }
        if(_showButton != 0) {
          cursor = SystemMouseCursors.click;
        }
      }

      if(controller == 'left') {
        if(((x > 199 && y > 173) && (x<229 && y<205)) || ((x>448 && y>175) && (x<476 && y<202))) {
          _showButton = 1;
        } else if(((x >484 && y > 190) && (x<509 && y<215))) {
          _showButton = 2;
        } else if(((x >499 && y > 230) && (x<510 && y<247))) {
          _showButton = 3;
        } else if(((x >520 && y > 196) && (x<528 && y<218))) {
          _showButton = 4;
        } else if(((x >527 && y > 156) && (x<549 && y<183))) {
          _showButton = 5;
        } else if(((x >498 && y > 159) && (x<515 && y<179))) {
          _showButton = 6;
        } else if(((x >581 && y > 179) && (x<603 && y<249))) {
          _showButton = 7;
        } else if(((x >184 && y > 413) && (x<210 && y<441))) {
          _showButton = 8;
        } else if(((x > 70 && y > 391) && (x<143 && y<494)) || ((x>526 && y>341) && (x<562 && y<426))) {
          _showButton = 9;
        } else if(((x > 215 && y > 290) && (x<251 && y<317)) || ((x>433 && y>275) && (x<455 && y<286))) {
          _showButton = 10;
        } else if(((x > 101 && y > 296) && (x<156 && y<330)) || ((x>536 && y>271) && (x<546 && y<306))) {
          _showButton = 11;
        } else if(((x > 37 && y > 326) && (x<78 && y<366)) || ((x>554 && y>274) && (x<590 && y<317))) {
          _showButton = 12;
        } else if(((x >291 && y > 404) && (x<372 && y<472))) {
          _showButton = 13;
        } else if(((x >165 && y > 499) && (x<234 && y<536)) || ((x>454 && y>481) && (x<514 && y< 517))) {
          _showButton = 14;
        } else if(((x >26 && y > 292) && (x<97 && y<313))) {
          _showButton = 898;
        } else {
          _showButton = 0;
          cursor = SystemMouseCursors.basic;
        }

        if(_showButton != 0) {
          cursor = SystemMouseCursors.click;
        }
      }


    });
  }
  


  
  @override
  Widget build(BuildContext context) {

    void addPressedButton(btn) {
      if(!_showButtons.contains(btn)) {
        _showButtons.add(btn); 
      }
    }

    void removePressedButton(btn) {
      if(_showButtons.contains(btn)) {
        _showButtons.removeAt(_showButtons.indexOf(btn));
      }
    }

    void updateShowButton(data) {

      if(_controlButton == 0 ) {
        data.b2 ? addPressedButton(11) : removePressedButton(11);
        data.b7 ? addPressedButton(1) : removePressedButton(1);
        data.b8 ? addPressedButton(6) : removePressedButton(6);
        data.b9 ? addPressedButton(4) : removePressedButton(4);
        data.b12 ? addPressedButton(8) : removePressedButton(8);


        if(data.b10 || data.b11 || data.b13 || data.b14) {
          addPressedButton(3);
        } else {
          removePressedButton(3);
        }

        if(data.b16 || data.b17 || data.b18) {
          addPressedButton(7);
        } else {
          removePressedButton(7);
        }

        if(data.b19 || data.b20 || data.b21 || data.b22 || data.b23 || data.b24 || data.b25 || data.b26 || data.b27) {
          addPressedButton(10);
        } else {
          removePressedButton(10);
        }

        if(data.b28 || data.b29 || data.b30 || data.b31 || data.b32 || data.b33 || data.b34 || data.b35 || data.b36) {
          addPressedButton(5);
        } else {
          removePressedButton(5);
        }

        if(data.b37 || data.b38 || data.b39 || data.b40 || data.b41 || data.b42 || data.b43 || data.b44 || data.b45) {
          addPressedButton(2);
        } else {
          removePressedButton(2);
        }
      }
    }


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
                return const Search();
                //return Text("No reportMessage stream");
              } else {
                var data = reportMessage.ReportMessage.fromBuffer(rustSignal.message as List<int>);
                updateShowButton(data);

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center, 
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Color.fromRGBO(30, 30, 30, 1),
                              Colors.black,
                            ],
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTapDown: (details) => clickPostion(details),
                            child :
                                MouseRegion(
                                  onHover: _updateLocation,
                                  cursor: cursor,
                                  child: Stack(
                                      fit: StackFit.expand,
                                      alignment: Alignment.center, 
                                      children: [
                                        Positioned(
                                          child: Image.asset('assets/$controller/controllers_and_base.png', width: 595, height: 464),
                                        ),

                                        Positioned(child: Image.asset('assets/$controller/btn-${_showButton.toString()}-selected.png', width: 595, height: 464),),
                                        for(var i in _showButtons) Positioned(child: Image.asset('assets/$controller/btn-${i.toString()}-selected.png', width: 595, height: 464),),

                                        // active
                                        Positioned(
                                          child: Opacity(opacity: 0.3, child: Image.asset('assets/$controller/btn-${_controlButton.toString()}-active.png', width: 595, height: 464)),
                                        ),

                                        // leds
                                        if(data.ledR != 0 && data.ledG != 0 && data.ledB != 0)
                                          Positioned(
                                            child: Opacity(
                                              opacity: 1, 
                                              child: Image.asset('assets/$controller/led-w.png', width: 595, height: 464)
                                            ),
                                          ),
                                          Positioned(
                                            child: Opacity(
                                              opacity: data.ledR * 100 / 255 * 0.01, 
                                              child: Image.asset('assets/$controller/led-r.png', width: 595, height: 464)
                                            ),
                                          ),
                                          Positioned(
                                            child: Opacity(
                                              opacity: data.ledG * 100 / 255 * 0.01, 
                                              child: Image.asset('assets/$controller/led-g.png', width: 595, height: 464)
                                            ),
                                          ),
                                          Positioned(
                                            child: Opacity(
                                              opacity: data.ledB * 100 / 255 * 0.01, 
                                              child: Image.asset('assets/$controller/led-b.png', width: 595, height: 464)
                                            ),
                                          ),
                                        if(_controlButton != 0) 
                                          Positioned(
                                            child: Opacity(opacity: 1, child: Image.asset('assets/$controller/btn-${_controlButton.toString()}-selected.png', width: 595, height: 464)),
                                          ),

                                        Positioned(
                                          top: 40,
                                          child: Text("${_showButtons}")),
                           
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
                                              //changeOnTap: false,

                                              onToggle:(index) {
                                                setState(() {
                                                  if(index==0) {
                                                    controller = 'left';
                                                  } else {
                                                    controller = 'right';
                                                  }
                                                  if(index != null) {
                                                    initialController = index;
                                                  }

                                                });
                                              },

                                              labels: const ['Left', 'Right'],
                                 
                                        ),
                                      ),

                                      ]
                                    )
                                  
                          
                            ),
                          )
                        )
                      )
                    ),

                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                          child: ListView(
                            children: [
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
                                if(_controlButton == 1)
                                  Button1(data: data),
                                if(_controlButton == 2)
                                  Button2(data: data),
                                if(_controlButton == 3)
                                  Button3(data: data),
                                if(_controlButton == 5)
                                  Button5(data: data),
                                if(_controlButton == 7)
                                  Button7(data: data),
                                if(_controlButton == 9)
                                  Button9(data: data),
                                if(_controlButton == 10)
                                  Button10(data: data),
                                if(_controlButton == 13)
                                  JoystickCalibartion(data: data),
                                if(_controlButton == 14)
                                  BaseRotation(data: data),
                                if(_controlButton == 898)
                                  LedColorPicker(data: data)

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