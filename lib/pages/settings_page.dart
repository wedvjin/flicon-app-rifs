

import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:drop_down_selector/drop_down_selector.dart';
import 'package:file_picker/file_picker.dart';

import 'package:blur/blur.dart';
import 'package:FC_Technologies/pages/search_page.dart';
import 'package:FC_Technologies/widgets/settings/base_calibration.dart';
import 'package:FC_Technologies/widgets/settings/base_rotation.dart';
import 'package:FC_Technologies/widgets/settings/button_1.dart';
import 'package:FC_Technologies/widgets/settings/button_10.dart';
import 'package:FC_Technologies/widgets/settings/button_2.dart';
import 'package:FC_Technologies/widgets/settings/button_3.dart';
import 'package:FC_Technologies/widgets/settings/button_5.dart';
import 'package:FC_Technologies/widgets/settings/button_7.dart';
import 'package:FC_Technologies/widgets/settings/brakes.dart';
import 'package:FC_Technologies/widgets/settings/gashetka.dart';
import 'package:FC_Technologies/widgets/settings/led_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:FC_Technologies/messages/report_message.pb.dart' as reportMessage;
import 'package:toggle_switch/toggle_switch.dart';
import 'package:keyboard_mouse_indicator/keyboard_mouse_indicator.dart';
import 'package:FC_Technologies/messages/device_info.pb.dart' as deviceInfo;

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  late final KeyboardIndicatorController mouseController = KeyboardIndicatorController();
  Offset? _tapPosition;

  List<String> profiles = <String>[];

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
  int topBarOffest = -18;

  String? _directoryPath;

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

  void clickPostion(TapDownDetails details) async {
    setState(() {
      double x = details.globalPosition.dx;
      double y = details.globalPosition.dy;

      if(controller == 'right') {
        if(((x > 97 && y > 161 + topBarOffest) && (x<129 && y<193 + topBarOffest)) || ((x>547 && y>166 + topBarOffest) && (x<574 && y<198 + topBarOffest))) {
          setControlButton(1);
        } else if(((x >136 && y > 176 + topBarOffest) && (x<162 && y<207 + topBarOffest))) {
          setControlButton(2);
        } else if(((x >152 && y > 222 + topBarOffest) && (x<163 && y<238 + topBarOffest))) {
          setControlButton(3);
        } else if(((x >175 && y > 186 + topBarOffest) && (x<197 && y<206 + topBarOffest))) {
          //setControlButton(4);
        } else if(((x >183 && y > 139 + topBarOffest) && (x<208 && y<170 + topBarOffest))) {
          setControlButton(5);
        } else if(((x >153 && y > 143 + topBarOffest) && (x<171 && y<166 + topBarOffest))) {
          //setControlButton(6);
        } else if(((x >243 && y > 168 + topBarOffest) && (x<268 && y<240 + topBarOffest))) {
          setControlButton(7);
        } else if(((x >535 && y > 389 + topBarOffest) && (x<556 && y<413 + topBarOffest))) {
          //setControlButton(8);
        } else if(((x > 188 && y > 348 + topBarOffest) && (x<222 && y<435 + topBarOffest)) || ((x>429 && y>370 + topBarOffest) && (x<484 && y<454 + topBarOffest))) {
          setControlButton(9);
        } else if(((x > 78 && y > 273 + topBarOffest) && (x<105 && y<285 + topBarOffest)) || ((x>563 && y>276 + topBarOffest) && (x<593 && y<300 + topBarOffest))) {
          setControlButton(10);
        } else if(((x > 191 && y > 269 + topBarOffest) && (x<209 && y<307 + topBarOffest)) || ((x>460 && y>286 + topBarOffest) && (x<502 && y<316 + topBarOffest))) {
          //setControlButton(11);
        } else if(((x > 215 && y > 271 + topBarOffest) && (x<252 && y<317 + topBarOffest)) || ((x>402 && y>309 + topBarOffest) && (x<434 && y<345 + topBarOffest))) {
          setControlButton(12);
        } else if(((x >291 && y > 404 + topBarOffest) && (x<372 && y<472 + topBarOffest))) {
          setControlButton(13);
        } else if(((x > 100 && y > 499 + topBarOffest) && (x<169 && y<539 + topBarOffest)) || ((x>518 && y>469 + topBarOffest) && (x<579 && y<505 + topBarOffest))) {
          setControlButton(14);
        } else if(((x >385 && y > 270 + topBarOffest) && (x<455 && y<297 + topBarOffest))) {
          setControlButton(898);
        } else {
          setControlButton(0);
        }
      }

      if(controller == 'left') {
        if(((x > 199 && y > 173 + topBarOffest) && (x<229 && y<205 + topBarOffest)) || ((x>448 && y>175 + topBarOffest) && (x<476 && y<202 + topBarOffest))) {
          setControlButton(1);
        } else if(((x >484 && y > 190 + topBarOffest) && (x<509 && y<215 + topBarOffest))) {
          setControlButton(2);
        } else if(((x >499 && y > 230 + topBarOffest) && (x<510 && y<247 + topBarOffest))) {
          setControlButton(3);
        } else if(((x >520 && y > 196 + topBarOffest) && (x<528 && y<218 + topBarOffest))) {
          //setControlButton(4);
        } else if(((x >527 && y > 156 + topBarOffest) && (x<549 && y<183 + topBarOffest))) {
          setControlButton(5);
        } else if(((x >498 && y > 159 + topBarOffest) && (x<515 && y<179 + topBarOffest))) {
          //setControlButton(6);
        } else if(((x >581 && y > 179 + topBarOffest) && (x<603 && y<249 + topBarOffest))) {
          setControlButton(7);
        } else if(((x >184 && y > 413 + topBarOffest) && (x<210 && y<441 + topBarOffest))) {
          //setControlButton(8);
        } else if(((x > 70 && y > 391 + topBarOffest) && (x<143 && y<494 + topBarOffest)) || ((x>526 && y>341 + topBarOffest) && (x<562 && y<426 + topBarOffest))) {
          setControlButton(9);
        } else if(((x > 215 && y > 290 + topBarOffest) && (x<251 && y<317 + topBarOffest)) || ((x>433 && y>275 + topBarOffest) && (x<455 && y<286 + topBarOffest))) {
          setControlButton(10);
        } else if(((x > 101 && y > 296 + topBarOffest) && (x<156 && y<330 + topBarOffest)) || ((x>536 && y>271 + topBarOffest) && (x<546 && y<306 + topBarOffest))) {
          //setControlButton(11);
        } else if(((x > 37 && y > 326 + topBarOffest) && (x<78 && y<366 + topBarOffest)) || ((x>554 && y>274 + topBarOffest) && (x<590 && y<317 + topBarOffest))) {
          setControlButton(12);
        } else if(((x >291 && y > 404 + topBarOffest) && (x<372 && y<472 + topBarOffest))) {
          setControlButton(13);
        } else if(((x >165 && y > 499 + topBarOffest) && (x<234 && y<536 + topBarOffest)) || ((x>454 && y>481 + topBarOffest) && (x<514 && y< 517 + topBarOffest))) {
          setControlButton(14);
        } else if(((x >26 && y > 292 + topBarOffest) && (x<97 && y<313 + topBarOffest))) {
          setControlButton(898);
        } else {
          setControlButton(0);
        }
      }
    });
  }

  final _dialogTitleController = TextEditingController();
  final _initialDirectoryController = TextEditingController();
  bool _lockParentWindow = false;
  bool _userAborted = false;
  FileType _pickingType = FileType.any;
  bool _multiPick = false;
  List<PlatformFile>? _paths;
  String? _extension;
  String hw_update_file_path = '';

  void _updateHW() async {
    try {
      _directoryPath = null;
      await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
        dialogTitle: _dialogTitleController.text,
        initialDirectory: _initialDirectoryController.text,
        lockParentWindow: _lockParentWindow,
      ).then((value) => {
        if(value?.files != null) {
          setState(() {
            if(value != null) {
              hw_update_file_path = value.files[0].path.toString();
              upgradeFW();
            }
          })
          
        }
      });
    } catch (e) {
      print(e);
    }
  }



  void _updateLocation(PointerEvent details) {
    setState(() {
      double x = details.position.dx;
      double y = details.position.dy;

      realX = details.position.dx;
      realY = details.position.dy;

      if(controller == 'right') {
        if(((x > 97 && y > 161 + topBarOffest) && (x<129 && y<193 + topBarOffest)) || ((x>547 && y>166 + topBarOffest) && (x<574 && y<198 + topBarOffest))) {
          _showButton = 1;
        } else if(((x >484 && y > 190 + topBarOffest) && (x<509 && y<215 + topBarOffest))) {
          _showButton = 2;
        } else if(((x >152 && y > 222 + topBarOffest) && (x<163 && y<238 + topBarOffest))) {
          _showButton = 3;
        } else if(((x >175 && y > 186 + topBarOffest) && (x<197 && y<206 + topBarOffest))) {
          _showButton = 4;
        } else if(((x >183 && y > 139 + topBarOffest) && (x<208 && y<170 + topBarOffest))) {
          _showButton = 5;
        } else if(((x >153 && y > 143 + topBarOffest) && (x<171 && y<166 + topBarOffest))) {
          _showButton = 6;
        } else if(((x >243 && y > 168 + topBarOffest) && (x<268 && y<240 + topBarOffest))) {
          _showButton = 7;
        } else if(((x >535 && y > 389 + topBarOffest) && (x<556 && y<413 + topBarOffest))) {
          _showButton = 8;
        } else if(((x > 188 && y > 348 + topBarOffest) && (x<222 && y<435 + topBarOffest)) || ((x>429 && y>370 + topBarOffest) && (x<484 && y<454 + topBarOffest))) {
          _showButton = 9;
        } else if(((x > 78 && y > 273 + topBarOffest) && (x<105 && y<285 + topBarOffest)) || ((x>563 && y>276 + topBarOffest) && (x<593 && y<300 + topBarOffest))) {
          _showButton = 10;
        } else if(((x > 191 && y > 269 + topBarOffest) && (x<209 && y<307 + topBarOffest)) || ((x>460 && y>286 + topBarOffest) && (x<502 && y<316 + topBarOffest))) {
          _showButton = 11;
        } else if(((x > 215 && y > 271 + topBarOffest) && (x<252 && y<317 + topBarOffest)) || ((x>402 && y>309 + topBarOffest) && (x<434 && y<345 + topBarOffest))) {
          _showButton = 12;
        } else if(((x >291 && y > 404 + topBarOffest) && (x<372 && y<472 + topBarOffest))) {
          _showButton = 13;
        } else if(((x > 100 && y > 499 + topBarOffest) && (x<169 && y<539 + topBarOffest)) || ((x>518 && y>469 + topBarOffest) && (x<579 && y<505 + topBarOffest))) {
          _showButton = 14;
        } else if(((x >385 && y > 270 + topBarOffest) && (x<455 && y<297 + topBarOffest))) {
          _showButton = 898;
        } else {
          _showButton = 0;
          cursor = SystemMouseCursors.basic;
        }
        if(_showButton != 0) {
          if(_showButton == 4 || _showButton == 6 || _showButton == 8 || _showButton == 11) {
            cursor = SystemMouseCursors.basic;
          } else {
            cursor = SystemMouseCursors.click;
          }
        }
      }

      if(controller == 'left') {
        if(((x > 199 && y > 173 + topBarOffest) && (x<229 && y<205 + topBarOffest)) || ((x>448 && y>175 + topBarOffest) && (x<476 && y<202 + topBarOffest))) {
          _showButton = 1;
        } else if(((x >484 && y > 190 + topBarOffest) && (x<509 && y<215 + topBarOffest))) {
          _showButton = 2;
        } else if(((x >499 && y > 230 + topBarOffest) && (x<510 && y<247 + topBarOffest))) {
          _showButton = 3;
        } else if(((x >520 && y > 196 + topBarOffest) && (x<528 && y<218 + topBarOffest))) {
          _showButton = 4;
        } else if(((x >527 && y > 156 + topBarOffest) && (x<549 && y<183 + topBarOffest))) {
          _showButton = 5;
        } else if(((x >498 && y > 159 + topBarOffest) && (x<515 && y<179 + topBarOffest))) {
          _showButton = 6;
        } else if(((x >581 && y > 179 + topBarOffest) && (x<603 && y<249 + topBarOffest))) {
          _showButton = 7;
        } else if(((x >184 && y > 413 + topBarOffest) && (x<210 && y<441 + topBarOffest))) {
          _showButton = 8;
        } else if(((x > 70 && y > 391 + topBarOffest) && (x<143 && y<494 + topBarOffest)) || ((x>526 && y>341 + topBarOffest) && (x<562 && y<426 + topBarOffest))) {
          _showButton = 9;
        } else if(((x > 215 && y > 290 + topBarOffest) && (x<251 && y<317 + topBarOffest)) || ((x>433 && y>275 + topBarOffest) && (x<455 && y<286 + topBarOffest))) {
          _showButton = 10;
        } else if(((x > 101 && y > 296 + topBarOffest) && (x<156 && y<330 + topBarOffest)) || ((x>536 && y>271 + topBarOffest) && (x<546 && y<306 + topBarOffest))) {
          _showButton = 11;
        } else if(((x > 37 && y > 326 + topBarOffest) && (x<78 && y<366 + topBarOffest)) || ((x>554 && y>274 + topBarOffest) && (x<590 && y<317 + topBarOffest))) {
          _showButton = 12;
        } else if(((x >291 && y > 404 + topBarOffest) && (x<372 && y<472 + topBarOffest))) {
          _showButton = 13;
        } else if(((x >165 && y > 499 + topBarOffest) && (x<234 && y<536 + topBarOffest)) || ((x>454 && y>481 + topBarOffest) && (x<514 && y< 517 + topBarOffest))) {
          _showButton = 14;
        } else if(((x >26 && y > 292 + topBarOffest) && (x<97 && y<313 + topBarOffest))) {
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

  String selectedProfile = '';
  final TextEditingController newProfile = TextEditingController();


  void loadProfile () {
    // do logic here
    // send rus_request
    // selected value = selectedProfile (string)
    print(selectedProfile);
    if (Platform.isWindows) {
      rust_request('readconf ' + selectedProfile, 0, 0, 0, 0, RustOperation.Update);
    }
  }

  void saveProfile() {
    // do logic here
    // send rus_request
    // entered value = newProfile.text (string)

    print(newProfile.text);
    if (Platform.isWindows) {
      rust_request('saveconf ' + newProfile.text, 0, 0, 0, 0, RustOperation.Update);
    }
  }

  void upgradeFW() {
    // do stuff here
    rust_request('enabledfu', 0, 0, 0, 0, RustOperation.Update);
    rust_request('upgradef ' + hw_update_file_path, 0, 0, 0, 0, RustOperation.Update);
    // print(hw_update_file_path);
  }



  Widget buildLoadDialog(BuildContext context) {
  if (!Platform.isWindows) {
    return AlertDialog(
      title: const Text('Oops'),
      content:
          const Text("We're sorry, but this feature is not supported in your OS. We'll support it later"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
      ],
    );
  } else {
    return FutureBuilder(
      future: rust_request('listconf', 0, 0, 0, 0, RustOperation.Update),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred while loading profiles.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          );
        } else {
          List<String> currentProfiles = snapshot.data.outputString.split(',');
          return AlertDialog(
            title: const Text('Select profile'),
            content: DropdownMenu<String>(
              enableFilter: false,
              enableSearch: false,
              width: 230,
              leadingIcon: const Icon(Icons.person),
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                fillColor: Color.fromARGB(255, 5, 5, 5),
                outlineBorder: BorderSide(color: Color.fromRGBO(193, 10, 10, 1)),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              ),
              onSelected: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  selectedProfile = value.toString();
                });
              },
              dropdownMenuEntries:
                currentProfiles.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  loadProfile();
                  Navigator.pop(context);
                },
                child: Text('Load'),
              ),
            ],
          );
        }
      },
    );
  }
}
//end

  // Widget buildLoadDialog(BuildContext context) {
  //   if(!Platform.isWindows) {
  //     return AlertDialog(
  //       title: const Text('Oops'),
  //       content: const Text("We're sorry, but this feature is not supported in your OS. We'll support it later"),
  //       actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Text('Close'),
  //           ),
  //         ],
  //     );
  //   } else {
  //     rust_request('listconf', 0, 0, 0, 0, RustOperation.Update).then((value) {
  //       print(value);
  //       List<String> currentProfiles = value.outputString.split(',');
  //       return AlertDialog(
  //         title: const Text('Select profile'),
  //         content: DropdownMenu<String>(
  //             enableFilter: false,
  //             enableSearch: false,
  //             width: 230,
  //             leadingIcon: const Icon(Icons.person),
  //             inputDecorationTheme: const InputDecorationTheme(
  //               filled: true,
  //               fillColor: Color.fromARGB(255, 5, 5, 5),
  //               outlineBorder: BorderSide(color: Color.fromRGBO(193, 10, 10, 1)),
  //               border: InputBorder.none,
  //               contentPadding:
  //                   EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
  //             ),
  //             onSelected: (String? value) {
  //               // This is called when the user selects an item.
  //               setState(() {
  //                 selectedProfile = value.toString();
  //               });
  //             },
  //             dropdownMenuEntries:
  //               currentProfiles.map<DropdownMenuEntry<String>>((String value) {
  //               return DropdownMenuEntry<String>(value: value, label: value);
  //             }).toList(),
  //           ),
            
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               loadProfile();
  //               Navigator.pop(context);
  //             },
  //             child: Text('Load'),
  //           ),
  //         ],
  //       );
  //     });

  //     if(!Platform.isWindows) {
  //       return AlertDialog(
  //         title: const Text('Oops'),
  //         content: const Text("We're sorry, but this feature is not supported in your OS. We'll support it later"),
  //         actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: Text('Close'),
  //             ),
  //           ],
  //       );
  //     } else {
  //       return Container();
  //     }
  //   }
  // }

    Widget buildSaveDialog(BuildContext context) {

      return AlertDialog(
        title: const Text('Save to profile'),
        content: TextField(
          controller: newProfile,
          decoration: InputDecoration(
            labelText: 'Enter profile name',
          ),
        ),
          
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              saveProfile();
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      );

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
              } else {
                var data = reportMessage.ReportMessage.fromBuffer(rustSignal.message as List<int>);
                updateShowButton(data);

                if(!data.connected) {
                  return const Search();
                }
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
                                Row(crossAxisAlignment: CrossAxisAlignment.start, 
                                  children: [
            
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child:Tooltip(
                                          message: 'Load saved profile settings',
                                          child: ElevatedButton(
                                          
                                            style: ElevatedButton.styleFrom(
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.zero),
                                                backgroundColor: Color.fromARGB(255, 5, 5, 5),
                                                foregroundColor: Colors.white),
                                            child: const SizedBox(
                                              height: 48, // Set a specific height
                                              child: Center(child:Icon(Icons.person))
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return buildLoadDialog(context); // Call the buildDialog function
                                                },
                                              );
                                            },
                                          ),)
                                      )),
                                      Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Tooltip(
                                          message: 'Save current settings to profile',
                                          child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 1,
                                              shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.zero),
                                              backgroundColor: Color.fromARGB(255, 5, 5, 5),
                                              foregroundColor: Colors.white),
                                              
                                          child: const SizedBox(
                                              height: 48, // Set a specific height
                                              child: Center(
                                                child: 
                                                Icon(Icons.save)
                                              )
                                            ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return buildSaveDialog(context); // Call the buildDialog function
                                              },
                                            );
                                          },
                                        ),
                                      ))),
                                      Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Tooltip(
                                          message: 'Update firmware',
                                          child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 1,
                                              shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.zero),
                                              backgroundColor: Color.fromARGB(255, 5, 5, 5),
                                              foregroundColor: Colors.white),
                                              
                                          child: const SizedBox(
                                              height: 48, // Set a specific height
                                              child: Center(
                                                child: 
                                                Icon(Icons.upgrade)
                                              )
                                            ),
                                          onPressed: () {
                                            _updateHW();
                                          },
                                        ),
                                      ))),
                              
                                  ]),
                                
                                const Divider(
                                  height: 20,
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
                                  Brake(data: data),
                                if(_controlButton == 10)
                                  Button10(data: data),
                                if(_controlButton == 12)
                                  Gashetka(data: data),
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
