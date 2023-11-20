

import 'dart:ffi';
import 'dart:io';
import 'dart:convert'; 
import 'package:flutter/services.dart' show rootBundle;

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
  List<int> _subButtons = [];
  int _controlButton = 0;
  var cursor = SystemMouseCursors.basic;
  int initialController = 1; // right
  String controller = 'right';
  final int min = 0;
  final int max = 10;
  final bool _flip = false;
  int topBarOffest = 0;

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

  var gripsConfig; 
  List<String> gripsList = [];

  List<String> alphaButtons = [];


  bool baseSelected = false;


  Future<void> loadJsonAsset() async { 
    final String jsonString = await rootBundle.loadString('assets/grips_config.json'); 

    final config = jsonDecode(jsonString); 
    setState(() { 
      gripsConfig = config; 
    });
  }

  @override 
  void initState() { 
    super.initState(); 
    loadJsonAsset(); 
  }


  void clickPostion(TapDownDetails details) async {
    setState(() {
      double x = details.globalPosition.dx;
      double y = details.globalPosition.dy;

      if(controller == 'right' && _selectedGrip == 'EVO') {
        if(((x > 98 && y > 156) && (x<129 && y<185)) || ((x>544 && y>161) && (x<573 && y<191))) {
          setControlButton(1);
        } else if(((x >134 && y > 173) && (x<159 && y<199))) {
          setControlButton(2);
        } else if(((x >150 && y > 215) && (x<165 && y<233))) {
          setControlButton(3);
        } else if(((x >172 && y > 178) && (x<192 && y<202))) {
          //setControlButton(4);
        } else if(((x >183 && y > 133) && (x<206 && y<163))) {
          setControlButton(5);
        } else if(((x >151 && y > 138) && (x<171 && y<159))) {
          //setControlButton(6);
        } else if(((x >239 && y > 159) && (x<265 && y<235))) {
          setControlButton(7);
        } else if(((x >532 && y > 381) && (x<555 && y<404))) {
          //setControlButton(8);
        } else if(((x > 185 && y > 338) && (x<222 && y<430)) || ((x>428 && y>360) && (x<495 && y<459))) {
          setControlButton(9);
        } else if(((x > 75 && y > 263) && (x<106 && y<281)) || ((x>560 && y>268) && (x<593 && y<292))) {
          setControlButton(10);
        } else if(((x > 195 && y > 260) && (x<207 && y<302)) || ((x>459 && y>275) && (x<507 && y<306))) {
          //setControlButton(11);
        } else if(((x > 210 && y > 262) && (x<252 && y<308)) || ((x>394 && y>297) && (x<433 && y<339))) {
          setControlButton(12);
        } else if(((x >301 && y > 378) && (x<347 && y<418))) {
          setControlButton(13);
        } else if(((x > 98 && y > 488) && (x<167 && y<527)) || ((x>516 && y>458) && (x<579 && y<495))) {
          setControlButton(14);
        } else if(((x >385 && y > 254) && (x<458 && y<293))) {
          setControlButton(898);
        } else {
          setControlButton(0);
        }
      }

      if(controller == 'left' && _selectedGrip == 'EVO') {
        if(((x > 536 && y > 151) && (x<569 && y<190)) || ((x>94 && y>160) && (x<119 && y<193))) {
          setControlButton(1);
        } else if(((x >504 && y > 169) && (x<534 && y<201))) {
          setControlButton(2);
        } else if(((x >497 && y > 212) && (x<520 && y<235))) {
          setControlButton(3);
        } else if(((x >471 && y > 179) && (x<494 && y<203))) {
          setControlButton(4);
        } else if(((x >458 && y > 132) && (x<486 && y<166))) {
          setControlButton(5);
        } else if(((x >493 && y > 136) && (x<516 && y<161))) {
          setControlButton(6);
        } else if(((x >399 && y > 168) && (x<428 && y<232))) {
          setControlButton(7);
        } else if(((x >114 && y > 378) && (x<132 && y<402))) {
          setControlButton(8);
        } else if(((x > 169 && y > 356) && (x<220 && y<446)) || ((x>435 && y>336) && (x<488 && y<430))) {
          setControlButton(9);
        } else if(((x > 73 && y > 268) && (x<110 && y<293)) || ((x>557 && y>263) && (x<591 && y<284))) {
          setControlButton(10);
        } else if(((x > 160 && y > 264) && (x<205 && y<304)) || ((x>454 && y>261) && (x<484 && y<299))) {
          setControlButton(11);
        } else if(((x > 229 && y > 295) && (x<269 && y<339)) || ((x>416 && y>269) && (x<449 && y<311))) {
          setControlButton(12);
        } else if(((x >321 && y > 377) && (x<364 && y<417))) {
          setControlButton(13);
        } else if(((x >90 && y > 459) && (x<150 && y<494)) || ((x>499 && y>494) && (x<568 && y< 527))) {
          setControlButton(14);
        } else if(((x >204 && y > 252) && (x<269 && y<297))) {
          setControlButton(898);
        } else {
          setControlButton(0);
        }
      }

      if(_selectedGrip == 'THRUSTMASTER') {
        if(((x > 517 && y > 281) && (x<580 && y<336))) {
          setControlButton(13);
          baseSelected = true;
        } else {
          setControlButton(0);
          baseSelected = false;
        }
      }

      if(_selectedGrip == 'ALPHA') {
        if(((x > 517 && y > 281) && (x<580 && y<336))) {
          setControlButton(13);
          baseSelected = true;
        } else if(((x > 39 && y > 89) && (x<95 && y<148))) {
          setControlButton(10);
          addAlphaButton('S1');
          removeAlphaButton('S2');
          removeAlphaButton('S3');
          removeAlphaButton('S4');
        } else if(((x > 117 && y > 89) && (x<176 && y<148))) {
          setControlButton(5);
          addAlphaButton('S2');
          removeAlphaButton('S1');
          removeAlphaButton('S3');
          removeAlphaButton('S4');
        } else if(((x > 197 && y > 89) && (x<256 && y<148))) {
          setControlButton(5);
          addAlphaButton('S3');
          removeAlphaButton('S1');
          removeAlphaButton('S2');
          removeAlphaButton('S4');
        } else if(((x > 277 && y > 89) && (x<337 && y<148))) {
          setControlButton(7);
          addAlphaButton('S4');
          removeAlphaButton('S1');
          removeAlphaButton('S2');
          removeAlphaButton('S3');
        } else if(((x > 41 && y > 187) && (x<91 && y<288)) || ((x>123 && y>190) && (x<171 && y< 287))) {
          setControlButton(1);
        } else if(((x > 202 && y > 187) && (x<252 && y<288))) {
          setControlButton(14);
        } else if(((x > 282 && y > 187) && (x<332 && y<288))) {
          setControlButton(9);
        } else {
          setControlButton(0);
          removeAlphaButton('S1');
          removeAlphaButton('S2');
          removeAlphaButton('S3');
          removeAlphaButton('S4');
          baseSelected = false;
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

  void addAlphaButton(btn) {
    if(!alphaButtons.contains(btn)) {
      alphaButtons.add(btn); 
    }
  }

  void removeAlphaButton(btn) {
    if(alphaButtons.contains(btn)) {
      alphaButtons.removeAt(alphaButtons.indexOf(btn));
    }
  }

  String _selectedGrip = 'EVO';
  List<String> _grips = ['EVO', 'ALPHA', 'THRUSTMASTER'];

  void _updateLocation(PointerEvent details) {
    setState(() {
      double x = details.position.dx;
      double y = details.position.dy;

      realX = details.position.dx;
      realY = details.position.dy;

      if(controller == 'right' && _selectedGrip == 'EVO') {
        if(((x > 98 && y > 156) && (x<129 && y<185)) || ((x>544 && y>161) && (x<573 && y<191))) {
          _showButton = 1;
        } else if(((x >134 && y > 173) && (x<159 && y<199))) {
          _showButton = 2;
        } else if(((x >150 && y > 215) && (x<165 && y<233))) {
          _showButton = 3;
        } else if(((x >172 && y > 178) && (x<192 && y<202))) {
          _showButton = 4;
        } else if(((x >183 && y > 133) && (x<206 && y<163))) {
          _showButton = 5;
        } else if(((x >151 && y > 138) && (x<171 && y<159))) {
          _showButton = 6;
        } else if(((x >239 && y > 159) && (x<265 && y<235))) {
          _showButton = 7;
        } else if(((x >532 && y > 381) && (x<555 && y<404))) {
          _showButton = 8;
        } else if(((x > 185 && y > 338) && (x<222 && y<430)) || ((x>428 && y>360) && (x<495 && y<459))) {
          _showButton = 9;
        } else if(((x > 75 && y > 263) && (x<106 && y<281)) || ((x>560 && y>268) && (x<593 && y<292))) {
          _showButton = 10;
        } else if(((x > 195 && y > 260) && (x<207 && y<302)) || ((x>459 && y>275) && (x<507 && y<306))) {
          _showButton = 11;
        } else if(((x > 210 && y > 262) && (x<252 && y<308)) || ((x>394 && y>297) && (x<433 && y<339))) {
          _showButton = 12;
        } else if(((x >301 && y > 378) && (x<347 && y<418))) {
          _showButton = 13;
        } else if(((x > 98 && y > 488) && (x<167 && y<527)) || ((x>516 && y>458) && (x<579 && y<495))) {
          _showButton = 14;
        } else if(((x >385 && y > 254) && (x<458 && y<293))) {
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

      if(controller == 'left' && _selectedGrip == 'EVO') {
        if(((x > 536 && y > 151) && (x<569 && y<190)) || ((x>94 && y>160) && (x<119 && y<193))) {
          _showButton = 1;
        } else if(((x >504 && y > 169) && (x<534 && y<201))) {
          _showButton = 2;
        } else if(((x >497 && y > 212) && (x<520 && y<235))) {
          _showButton = 3;
        } else if(((x >471 && y > 179) && (x<494 && y<203))) {
          _showButton = 4;
        } else if(((x >458 && y > 132) && (x<486 && y<166))) {
          _showButton = 5;
        } else if(((x >493 && y > 136) && (x<516 && y<161))) {
          _showButton = 6;
        } else if(((x >399 && y > 168) && (x<428 && y<232))) {
          _showButton = 7;
        } else if(((x >114 && y > 378) && (x<132 && y<402))) {
          _showButton = 8;
        } else if(((x > 169 && y > 356) && (x<220 && y<446)) || ((x>435 && y>336) && (x<488 && y<430))) {
          _showButton = 9;
        } else if(((x > 73 && y > 268) && (x<110 && y<293)) || ((x>557 && y>263) && (x<591 && y<284))) {
          _showButton = 10;
        } else if(((x > 160 && y > 264) && (x<205 && y<304)) || ((x>454 && y>261) && (x<484 && y<299))) {
          _showButton = 11;
        } else if(((x > 229 && y > 295) && (x<269 && y<339)) || ((x>416 && y>269) && (x<449 && y<311))) {
          _showButton = 12;
        } else if(((x >321 && y > 377) && (x<364 && y<417))) {
          _showButton = 13;
        } else if(((x >90 && y > 459) && (x<150 && y<494)) || ((x>499 && y>494) && (x<568 && y< 527))) {
          _showButton = 14;
        } else if(((x >204 && y > 252) && (x<269 && y<297))) {
          _showButton = 898;
        } else {
          _showButton = 0;
          cursor = SystemMouseCursors.basic;
        }

        if(_showButton != 0) {
          cursor = SystemMouseCursors.click;
        }
      }

      if(_selectedGrip == 'ALPHA' || _selectedGrip == 'THRUSTMASTER') {
        if(((x > 517 && y > 281) && (x<580 && y<336))) {
          _showButton = 13;
        } else {
          _showButton = 0;
          cursor = SystemMouseCursors.basic;
        }

        if(_showButton != 0) {
          cursor = SystemMouseCursors.click;
        }
      }

      if(_selectedGrip == 'ALPHA') {
        if(((x > 39 && y > 89) && (x<95 && y<148))) {
          _showButton = 1;
        } else if(((x > 41 && y > 187) && (x<91 && y<288)) || ((x>123 && y>190) && (x<171 && y< 287))) {
          _showButton = 33;
        } else if(((x > 202 && y > 187) && (x<252 && y<288))) {
          _showButton = 33;
        } else if(((x > 282 && y > 187) && (x<332 && y<288))) {
          _showButton = 33;
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

    void addSubButton(btn) {
      if(!_subButtons.contains(btn)) {
        _subButtons.add(btn); 
      }
    }

    void removeSubButton(btn) {
      if(_subButtons.contains(btn)) {
        _subButtons.removeAt(_subButtons.indexOf(btn));
      }
    }

    void updateShowButton(data) {
      if(_controlButton == 0 ) {
        data.b2 ? addPressedButton(11) : removePressedButton(11);
        data.b7 ? addPressedButton(1) : removePressedButton(1);
        data.b8 ? addPressedButton(6) : removePressedButton(6);
        data.b9 ? addPressedButton(4) : removePressedButton(4);
        data.b12 ? addPressedButton(8) : removePressedButton(8);

        if(data.b4 || data.b5 || data.b6) {
          addSubButton(4);
        } else {
          removeSubButton(4);
        }


        if(data.b10 || data.b11 || data.b13 || data.b14) {
          addPressedButton(3);
          addSubButton(3000000000000000);
          data.b10 ? addSubButton(10) : removeSubButton(10);
          data.b11 ? addSubButton(11) : removeSubButton(11);
          data.b13 ? addSubButton(13) : removeSubButton(13);
          data.b14 ? addSubButton(14) : removeSubButton(14);
        } else {
          removePressedButton(3);
          removeSubButton(3000000000000000);
          removeSubButton(10);
          removeSubButton(11);
          removeSubButton(13);
          removeSubButton(14);
        }

        if(data.b16 || data.b17 || data.b18) {
          addPressedButton(7);
          addSubButton(7000000000000000);
          data.b16 ? addSubButton(16) : removeSubButton(16);
          data.b17 ? addSubButton(17) : removeSubButton(17);
          data.b18 ? addSubButton(18) : removeSubButton(18);
        } else {
          removePressedButton(7);
          removeSubButton(7000000000000000);
          removeSubButton(16);
          removeSubButton(17);
          removeSubButton(18);
        }

        if(data.b19 || data.b20 || data.b21 || data.b22 || data.b23 || data.b24 || data.b25 || data.b26 || data.b27) {
          addPressedButton(10);
          addSubButton(1000000000000000);

          data.b19 ? addSubButton(19) : removeSubButton(19);
          data.b20 ? addSubButton(20) : removeSubButton(20);
          data.b21 ? addSubButton(21) : removeSubButton(21);
          data.b22 ? addSubButton(22) : removeSubButton(22);
          data.b23 ? addSubButton(23) : removeSubButton(23);
          data.b24 ? addSubButton(24) : removeSubButton(24);
          data.b25 ? addSubButton(25) : removeSubButton(25);
          data.b26 ? addSubButton(26) : removeSubButton(26);
          data.b27 ? addSubButton(27) : removeSubButton(27);
        } else {
          removePressedButton(10);
          removeSubButton(1000000000000000);
          removeSubButton(19);
          removeSubButton(20);
          removeSubButton(21);
          removeSubButton(22);
          removeSubButton(23);
          removeSubButton(24);
          removeSubButton(25);
          removeSubButton(26);
          removeSubButton(27);
        }

        if(data.b28 || data.b29 || data.b30 || data.b31 || data.b32 || data.b33 || data.b34 || data.b35 || data.b36) {
          addPressedButton(5);
          addSubButton(5000000000000000);
          data.b28 ? addSubButton(28) : removeSubButton(28);
          data.b29 ? addSubButton(29) : removeSubButton(29);
          data.b30 ? addSubButton(30) : removeSubButton(30);
          data.b31 ? addSubButton(31) : removeSubButton(31);
          data.b32 ? addSubButton(32) : removeSubButton(32);
          data.b33 ? addSubButton(33) : removeSubButton(33);
          data.b34 ? addSubButton(34) : removeSubButton(34);
          data.b35 ? addSubButton(35) : removeSubButton(35);
          data.b36 ? addSubButton(36) : removeSubButton(36);
          
        } else {
          removePressedButton(5);
          removeSubButton(5000000000000000);
          removeSubButton(28);
          removeSubButton(29);
          removeSubButton(30);
          removeSubButton(31);
          removeSubButton(32);
          removeSubButton(33);
          removeSubButton(34);
          removeSubButton(35);
          removeSubButton(36);
        }

        if(data.b37 || data.b38 || data.b39 || data.b40 || data.b41 || data.b42 || data.b43 || data.b44 || data.b45) {
          addPressedButton(2);
          addSubButton(2000000000000000);
          data.b37 ? addSubButton(37) : removeSubButton(37);
          data.b38 ? addSubButton(38) : removeSubButton(38);
          data.b39 ? addSubButton(39) : removeSubButton(39);
          data.b40 ? addSubButton(40) : removeSubButton(40);
          data.b41 ? addSubButton(41) : removeSubButton(41);
          data.b42 ? addSubButton(42) : removeSubButton(42);
          data.b43 ? addSubButton(43) : removeSubButton(43);
          data.b44 ? addSubButton(44) : removeSubButton(44);
          data.b45 ? addSubButton(45) : removeSubButton(45);
        } else {
          removePressedButton(2);
          removeSubButton(2000000000000000);
          removeSubButton(37);
          removeSubButton(38);
          removeSubButton(39);
          removeSubButton(40);
          removeSubButton(41);
          removeSubButton(42);
          removeSubButton(43);
          removeSubButton(44);
          removeSubButton(45);
        }
      }
    }


    Color mainColor = Color.fromARGB(255, 82, 82, 82);
    Color secondaryColor = Color.fromRGBO(221, 221, 221, 1);

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 24, 24, 24),
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

                if(data.idGrib == 1 && _selectedGrip != "EVO") {
                  _selectedGrip = 'EVO';
                }
                if(data.idGrib == 2 && _selectedGrip != "ALPHA") {
                    _selectedGrip = 'ALPHA';
                }
                if(data.idGrib == 3 && _selectedGrip != "ALPHA") {
                    _selectedGrip = 'ALPHA';
                }
                if(data.idGrib == 4 && _selectedGrip != "THRUSTMASTER") {
                    _selectedGrip = 'THRUSTMASTER';
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
                              Color.fromARGB(255, 55, 55, 55),
                              Color.fromARGB(255, 24, 24, 24),
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
                                        if(_selectedGrip == 'EVO')
                                          Positioned(
                                            child: Image.asset('assets/$controller/controllers_and_base.png', width: 586, height: 457),
                                          ),
                                        if(_selectedGrip == 'EVO')
                                          Positioned(child: Image.asset('assets/$controller/btn-${_showButton.toString()}-selected.png', width: 586, height: 457),),
                                        if(_selectedGrip == 'EVO')
                                          for(var i in _showButtons) Positioned(child: Image.asset('assets/$controller/btn-${i.toString()}-selected.png', width: 586, height: 457),),
                                        if(_selectedGrip == 'EVO')
                                          for(var i in _subButtons) Positioned(child: Image.asset('assets/$controller/sub_btn_${i.toString()}.png', width: 586, height: 457),),                                    

                                        if(data.ledR != 0 && data.ledG != 0 && data.ledB != 0 && _selectedGrip == 'EVO')
                                          Positioned(
                                            child: Opacity(
                                              opacity: 1, 
                                              child: Image.asset('assets/$controller/led-w.png', width: 586, height: 457)
                                            ),
                                          ),
                                        if(data.ledR != 0 && data.ledG != 0 && data.ledB != 0 && _selectedGrip == 'EVO')
                                          Positioned(
                                            child: Opacity(
                                              opacity: data.ledR * 100 / 255 * 0.01, 
                                              child: Image.asset('assets/$controller/led-r.png', width: 586, height: 457)

                                            ),
                                          ),
                                        if(data.ledR != 0 && data.ledG != 0 && data.ledB != 0 && _selectedGrip == 'EVO')
                                          Positioned(
                                            child: Opacity(
                                              opacity: data.ledG * 100 / 255 * 0.01, 
                                              child: Image.asset('assets/$controller/led-g.png', width: 586, height: 457)
                                            ),
                                          ),
                                        if(data.ledR != 0 && data.ledG != 0 && data.ledB != 0 && _selectedGrip == 'EVO')
                                          Positioned(
                                            child: Opacity(
                                              opacity: data.ledB * 100 / 255 * 0.01, 
                                              child: Image.asset('assets/$controller/led-b.png', width: 586, height: 457)
                                            ),
                                          ),
                                        if(_controlButton != 0 && _selectedGrip == 'EVO') 
                                          Positioned(
                                            child: Opacity(opacity: 1, child: Image.asset('assets/$controller/btn-${_controlButton.toString()}-selected.png', width: 586, height: 457)),
                                          ),

                                        // show rx axis
                                        if(_selectedGrip == 'EVO' && controller == 'right')
                                          Positioned(
                                            top: 100,
                                            left: 25,
                                            child: Container(
                                              height: 20,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 31, 31, 31),
                                                border: Border.all(color: Colors.white),
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
                                              ),
                                              child: 
                                                SizedBox(
                                                  height: 20,
                                                  width: 50,
                                                  child:
                                                    RotatedBox(
                                                      quarterTurns: 2,
                                                      child: LinearProgressIndicator(
                                                        minHeight: 50.0,
                                                        value: ((data.rxAxis - ((data.rxMax + data.rxMin) / 2)) / (data.rxMax - data.rxMin)) <= 0 ? ((data.rxAxis - ((data.rxMax + data.rxMin) / 2)) / (data.rxMax - data.rxMin)).abs().toDouble() * 2 : 0.0,
                                                        valueColor: AlwaysStoppedAnimation(Color.fromRGBO(193, 10, 10, 1)),
                                                        backgroundColor: Colors.transparent,
                                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
                                                      ),
                                                    ),
                                                ),
                                                
                                              
                                            )
                                          ),
                                        if(_selectedGrip == 'EVO' && controller == 'right')
                                          Positioned(
                                            top: 100,
                                            left: 70,
                                            child: Container(
                                              height: 20,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 31, 31, 31),
                                                border: Border.all(color: Colors.white),
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              ),
                                              child: 
                                                SizedBox(
                                                  height: 20,
                                                  width: 50,
                                                  child:
                                                    RotatedBox(
                                                      quarterTurns: 0,
                                                      child: LinearProgressIndicator(
                                                        minHeight: 50.0,
                                                        value: ((data.rxAxis - ((data.rxMax + data.rxMin) / 2)) / (data.rxMax - data.rxMin)).toDouble() * 2,
                                                        valueColor: AlwaysStoppedAnimation(Color.fromRGBO(193, 10, 10, 1)),
                                                        backgroundColor: Colors.transparent,
                                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
                                                      ),
                                                    ),
                                                ),
                                            )
                                          ),
                                        if(_selectedGrip == 'EVO' && controller == 'right')
                                          Positioned(
                                            top: 65,
                                            left: 60,
                                            child: Container(
                                              height: 45,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 31, 31, 31),
                                                border: Border.all(color: Colors.white),
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))
                                              ),
                                              child: 
                                                SizedBox(
                                                  height: 20,
                                                  width: 50,
                                                  child:
                                                    RotatedBox(
                                                      quarterTurns: -1,
                                                      child: LinearProgressIndicator(
                                                        minHeight: 50.0,
                                                        value: ((data.ryAxis - ((data.ryMax + data.ryMin) / 2)) / (data.ryMax - data.ryMin)) <= 0 ? ((data.ryAxis - ((data.ryMax + data.ryMin) / 2)) / (data.ryMax - data.ryMin)).abs().toDouble() * 2 : 0.0,
                                                        valueColor: AlwaysStoppedAnimation(Color.fromRGBO(193, 10, 10, 1)),
                                                        backgroundColor: Colors.transparent,
                                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
                                                      ),
                                                    ),
                                                ),
                                            )
                                          ),
                                        if(_selectedGrip == 'EVO' && controller == 'right')
                                          Positioned(
                                            top: 110,
                                            left: 60,
                                            child: Container(
                                              height: 45,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 31, 31, 31),
                                                border: Border.all(color: Colors.white),
                                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))
                                              ),
                                              child: 
                                                SizedBox(
                                                  height: 20,
                                                  width: 50,
                                                  child:
                                                    RotatedBox(
                                                      quarterTurns: 1,
                                                      child: LinearProgressIndicator(
                                                        minHeight: 50.0,
                                                        value: ((data.ryAxis - ((data.ryMax + data.ryMin) / 2)) / (data.ryMax - data.ryMin)).toDouble() * 2,
                                                        valueColor: AlwaysStoppedAnimation(Color.fromRGBO(193, 10, 10, 1)),
                                                        backgroundColor: Colors.transparent,
                                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
                                                      ),
                                                    ),
                                                ),
                                            )
                                          ),
                                        if(_selectedGrip == 'EVO' && controller == 'right')
                                          Positioned(
                                            top: 95,
                                            left: 55,
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: data.b7 ? Color.fromRGBO(193, 10, 10, 1) : const Color.fromARGB(255, 31, 31, 31),
                                                border: Border.all(color: Colors.white),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),

                                        // show x,y axis
                                        if(_selectedGrip == 'EVO' && controller == 'right')
                                          Positioned(
                                            bottom: 285,
                                            left: 275,
                                            child: Container(
                                              height: 20,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 31, 31, 31),
                                                border: Border.all(color: Colors.white),
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
                                              ),
                                              child: 
                                                SizedBox(
                                                  height: 20,
                                                  width: 50,
                                                  child:
                                                    RotatedBox(
                                                      quarterTurns: 2,
                                                      child: LinearProgressIndicator(
                                                        minHeight: 50.0,
                                                        value: ((data.xAxis - ((data.xMax + data.xMin) / 2)) / (data.xMax - data.xMin)) <= 0 ? ((data.xAxis - ((data.xMax + data.xMin) / 2)) / (data.xMax - data.xMin)).abs().toDouble() * 2 : 0.0,
                                                        valueColor: AlwaysStoppedAnimation(Color.fromRGBO(193, 10, 10, 1)),
                                                        backgroundColor: Colors.transparent,
                                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
                                                      ),
                                                    ),
                                                ),
                                                
                                              
                                            )
                                          ),
                                        if(_selectedGrip == 'EVO' && controller == 'right')
                                          Positioned(
                                            bottom: 285,
                                            left: 318,
                                            child: Container(
                                              height: 20,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 31, 31, 31),
                                                border: Border.all(color: Colors.white),
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              ),
                                              child: 
                                                SizedBox(
                                                  height: 20,
                                                  width: 50,
                                                  child:
                                                    RotatedBox(
                                                      quarterTurns: 0,
                                                      child: LinearProgressIndicator(
                                                        minHeight: 50.0,
                                                        value: ((data.xAxis - ((data.xMax + data.xMin) / 2)) / (data.xMax - data.xMin)).toDouble() * 2,
                                                        valueColor: AlwaysStoppedAnimation(Color.fromRGBO(193, 10, 10, 1)),
                                                        backgroundColor: Colors.transparent,
                                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
                                                      ),
                                                    ),
                                                ),
                                            )
                                          ),
                                        if(_selectedGrip == 'EVO' && controller == 'right')
                                          Positioned(
                                            bottom: 295,
                                            left: 308,
                                            child: Container(
                                              height: 45,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 31, 31, 31),
                                                border: Border.all(color: Colors.white),
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))
                                              ),
                                              child: 
                                                SizedBox(
                                                  height: 20,
                                                  width: 50,
                                                  child:
                                                    RotatedBox(
                                                      quarterTurns: -1,
                                                      child: LinearProgressIndicator(
                                                        minHeight: 50.0,
                                                        value: ((data.yAxis - ((data.yMax + data.yMin) / 2)) / (data.yMax - data.yMin)).toDouble() * 2,
                                                        valueColor: AlwaysStoppedAnimation(Color.fromRGBO(193, 10, 10, 1)),
                                                        backgroundColor: Colors.transparent,
                                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
                                                      ),
                                                    ),
                                                ),
                                            )
                                          ),
                                        if(_selectedGrip == 'EVO' && controller == 'right')
                                          Positioned(
                                            bottom: 250,
                                            left: 308,
                                            child: Container(
                                              height: 45,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 31, 31, 31),
                                                border: Border.all(color: Colors.white),
                                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))
                                              ),
                                              child: 
                                                SizedBox(
                                                  height: 20,
                                                  width: 50,
                                                  child:
                                                    RotatedBox(
                                                      quarterTurns: 1,
                                                      child: LinearProgressIndicator(
                                                        minHeight: 50.0,
                                                        value: ((data.yAxis - ((data.yMax + data.yMin) / 2)) / (data.yMax - data.yMin)) <= 0 ? ((data.yAxis - ((data.yMax + data.yMin) / 2)) / (data.yMax - data.yMin)).abs().toDouble() * 2 : 0.0,

                                                        valueColor: AlwaysStoppedAnimation(Color.fromRGBO(193, 10, 10, 1)),
                                                        backgroundColor: Colors.transparent,
                                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
                                                      ),
                                                    ),
                                                ),
                                            )
                                          ),
                                        if(_selectedGrip == 'EVO' && controller == 'right')
                                          Positioned(
                                            bottom: 280,
                                            left: 303,
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 31, 31, 31),
                                                border: Border.all(color: Colors.white),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),

                                        // z axis
                                        if(_selectedGrip == 'EVO' && controller == 'right')
                                          Positioned(
                                            bottom: 50,
                                            left: 80,
                                            child: Container(
                                              height: 20,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 31, 31, 31),
                                                border: Border.all(color: Colors.white),
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
                                              ),
                                              child: 
                                                SizedBox(
                                                  height: 20,
                                                  width: 50,
                                                  child:
                                                    RotatedBox(
                                                      quarterTurns: 2,
                                                      child: LinearProgressIndicator(
                                                        minHeight: 50.0,
                                                        value: ((data.zAxis - ((data.zMax + data.zMin) / 2)) / (data.zMax - data.zMin)) <= 0 ? ((data.zAxis - ((data.zMax + data.zMin) / 2)) / (data.zMax - data.zMin)).abs().toDouble() * 2 : 0.0,
                                                        valueColor: AlwaysStoppedAnimation(Color.fromRGBO(193, 10, 10, 1)),
                                                        backgroundColor: Colors.transparent,
                                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
                                                      ),
                                                    ),
                                                ),
                                                
                                              
                                            )
                                          ),
                                        if(_selectedGrip == 'EVO' && controller == 'right')
                                          Positioned(
                                            bottom: 50,
                                            left: 125,
                                            child: Container(
                                              height: 20,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 31, 31, 31),
                                                border: Border.all(color: Colors.white),
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              ),
                                              child: 
                                                SizedBox(
                                                  height: 20,
                                                  width: 50,
                                                  child:
                                                    RotatedBox(
                                                      quarterTurns: 0,
                                                      child: LinearProgressIndicator(
                                                        minHeight: 50.0,
                                                        value: ((data.zAxis - ((data.zMax + data.zMin) / 2)) / (data.zMax - data.zMin)).toDouble() * 2,
                                                        valueColor: AlwaysStoppedAnimation(Color.fromRGBO(193, 10, 10, 1)),
                                                        backgroundColor: Colors.transparent,
                                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
                                                      ),
                                                    ),
                                                ),
                                            )
                                          ),

                                        //brakes
                                        if(_selectedGrip == 'EVO' && controller == 'right')
                                          Positioned(
                                            bottom: 140,
                                            right: 170,
                                            child: Container(
                                              height: 20,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 31, 31, 31),
                                                border: Border.all(color: Colors.white),
                                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15), topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                                              ),
                                              child: 
                                                SizedBox(
                                                  height: 20,
                                                  width: 50,
                                                  child:
                                                    RotatedBox(
                                                      quarterTurns: 2,
                                                      child: LinearProgressIndicator(
                                                        minHeight: 50.0,
                                                        value: ((data.sliderAxis - ((data.sliderMax + data.sliderMin) / 2)) / (data.sliderMax - data.sliderMin)).toDouble() * 2,
                                                        valueColor: AlwaysStoppedAnimation(Color.fromRGBO(193, 10, 10, 1)),
                                                        backgroundColor: Colors.transparent,
                                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15), topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                                                      ),
                                                    ),
                                                ),
                                                
                                              
                                            )
                                          ),

                                    
                                        if(_selectedGrip == 'EVO' || _selectedGrip == 'ALPHA')
                                          Positioned(
                                            bottom: 20,
                                            child:
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
                                          if((_selectedGrip == 'THRUSTMASTER' || _selectedGrip == 'ALPHA') && baseSelected)
                                              Positioned(
                                                top: 220,
                                                right: 0,
                                                child: Image.asset('assets/base-selected.png', width: 220),
                                              ),
                                          if((_selectedGrip == 'THRUSTMASTER' || _selectedGrip == 'ALPHA') && !baseSelected)
                                              Positioned(
                                                top: 220,
                                                right: 0,
                                                child: Image.asset('assets/base.png', width: 220),
                                              ),
                                          if(_selectedGrip == 'THRUSTMASTER')
                                            for(var x in gripsConfig['THRUSTMASTER']['buttons'])
                                              Positioned(
                                                top: x['offset'],
                                                left: 20,
                                                child: 
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    for(var i in x['buttons'])
                                                      Padding(
                                                        padding: EdgeInsets.all(10),
                                                        child: 
                                                        SizedBox(
                                                          width: 60,
                                                          child: Column(                                                          
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 10),
                                                              child: Text('Button ${i}', style: TextStyle(fontSize: 13),),
                                                            ),
                                                            Container(
                                                                  width: 50,
                                                                  height: 50,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.transparent,
                                                                    shape: BoxShape.circle,
                                                                    border:Border.all(
                                                                      color: Colors.white,// Border color
                                                                      width: 2.0,           // Border width
                                                                    ),
                                                                    boxShadow: [
                                                                      if(_subButtons.indexOf(i) > 0)
                                                                        const BoxShadow(
                                                                          color: Color.fromRGBO(193, 10, 10, 1),
                                                                          blurRadius: 20.0,
                                                                          spreadRadius: 0.0,
                                                                          offset: Offset(0.0, 0.0),
                                                                          blurStyle: BlurStyle.outer
                                                                        ),
                                                                    ],
                                                                  ),
                                                                  
                                                                  child: Padding(
                                                                    padding: EdgeInsets.all(5), 
                                                                    child: Container(
                                                                      width: 40,
                                                                      height: 40,
                                                                      decoration: const BoxDecoration(
                                                                        color: Color.fromRGBO(193, 10, 10, 1),
                                                                        shape: BoxShape.circle,
                                                                      )
                                                                    )
                                                                  )
                                                                
                                                                ),
                                                          ]
                                                        )
                                                        )

                                                      ),
                                                  ]
                                                )
                                              ),
                                          if(_selectedGrip == 'ALPHA')
                                            for(var x in gripsConfig['ALPHA']['multibuttons'])
                                              Positioned(
                                                top: x['offset'],
                                                left: 20,
                                                child: 
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    for(var i in x['buttons'])
                                                      Padding(
                                                        padding: EdgeInsets.all(10),
                                                        child: 
                                                        SizedBox(
                                                          width: 60,
                                                          child: Column(                                                          
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 10),
                                                              child: Text('S${i}', style: TextStyle(fontSize: 13),),
                                                            ),
                                                            Container(
                                                                  width: 80,
                                                                  height: 80,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.transparent,
                                                                    shape: BoxShape.circle,
                                                                    border:Border.all(
                                                                      color: Colors.white,// Border color
                                                                      width: 1.0,           // Border width
                                                                    ),
                                                                    boxShadow: [
                                                                      if((alphaButtons.indexOf("S${i}") >= 0))
                                                                        const BoxShadow(
                                                                          color: Color.fromRGBO(193, 10, 10, 1),
                                                                          blurRadius: 20.0,
                                                                          spreadRadius: 0.0,
                                                                          offset: Offset(0.0, 0.0),
                                                                          blurStyle: BlurStyle.outer
                                                                        ),
                                                                      if(i == 1 && (data.b19 || data.b20 || data.b21 || data.b22 || data.b23 || data.b24 || data.b25 || data.b26 || data.b27))
                                                                        const BoxShadow(
                                                                          color: Color.fromRGBO(193, 10, 10, 1),
                                                                          blurRadius: 20.0,
                                                                          spreadRadius: 0.0,
                                                                          offset: Offset(0.0, 0.0),
                                                                          blurStyle: BlurStyle.outer
                                                                        ),
                                                                      if(i == 2 && (data.b37 || data.b38 || data.b39 || data.b40 || data.b41 || data.b42 || data.b43 || data.b44 || data.b45))
                                                                        const BoxShadow(
                                                                          color: Color.fromRGBO(193, 10, 10, 1),
                                                                          blurRadius: 20.0,
                                                                          spreadRadius: 0.0,
                                                                          offset: Offset(0.0, 0.0),
                                                                          blurStyle: BlurStyle.outer
                                                                        ),
                                                                      if(i == 3 && (data.b28 || data.b29 || data.b30 || data.b31 || data.b32 || data.b33 || data.b34 || data.b35 || data.b36))
                                                                        const BoxShadow(
                                                                          color: Color.fromRGBO(193, 10, 10, 1),
                                                                          blurRadius: 20.0,
                                                                          spreadRadius: 0.0,
                                                                          offset: Offset(0.0, 0.0),
                                                                          blurStyle: BlurStyle.outer
                                                                        ),
                                                                      if(i == 4 && (data.b16 || data.b17 || data.b18))
                                                                        const BoxShadow(
                                                                          color: Color.fromRGBO(193, 10, 10, 1),
                                                                          blurRadius: 20.0,
                                                                          spreadRadius: 0.0,
                                                                          offset: Offset(0.0, 0.0),
                                                                          blurStyle: BlurStyle.outer
                                                                        ),
                                                                    ],
                                                                  ),
                                                                  
                                                                  child: Wrap(
                                                                    direction: Axis.vertical,
                                                                    runAlignment: WrapAlignment.center,
                                                                    alignment: WrapAlignment.center,
                                                                    children: [
                                                                      if(i== 4 && !data.b16 && !data.b17 && !data.b18)
                                                                        Image.asset('assets/2-axis-button/ALPHA/S4_000.png', width: 50, height: 50),
                                                                      if(i== 4 && data.b16)
                                                                        Image.asset('assets/2-axis-button/ALPHA/S4_016.png', width: 50, height: 50),
                                                                      if(i==4 && data.b17)
                                                                        Image.asset('assets/2-axis-button/ALPHA/S4_017.png', width: 50, height: 50),
                                                                      if(i==4 && data.b18)
                                                                        Image.asset('assets/2-axis-button/ALPHA/S4_018.png', width: 50, height: 50),
                                                                      if(i == 1 && !data.b19 && !data.b20 && !data.b21 && !data.b22 && !data.b23 && !data.b24 && !data.b25 && !data.b26 && !data.b27)  
                                                                        Image.asset('assets/multidirectional_button/ALPHA/S1_000.png', width: 50, height: 50),
                                                                      if(i == 2 && !data.b37 && !data.b38 && !data.b39 && !data.b40 && !data.b41 && !data.b42 && !data.b43 && !data.b44 && !data.b45)
                                                                        Image.asset('assets/multidirectional_button/ALPHA/S1_000.png', width: 50, height: 50),
                                                                      if(i == 3 && !data.b28 && !data.b29 && !data.b30 && !data.b31 && !data.b32 && !data.b33 && !data.b34 && !data.b35 && !data.b36)
                                                                        Image.asset('assets/multidirectional_button/ALPHA/S1_000.png', width: 50, height: 50),
                                                                      if((i == 1 && data.b19) || (i == 2 && data.b37) || (i == 3 && data.b28) )
                                                                        Image.asset('assets/multidirectional_button/ALPHA/S1_001.png', width: 50, height: 50),
                                                                      if((i == 1 && data.b20) || (i == 2 && data.b38) || (i == 3 && data.b29) )
                                                                        Image.asset('assets/multidirectional_button/ALPHA/S1_002.png', width: 50, height: 50),
                                                                      if((i == 1 && data.b21) || (i == 2 && data.b39) || (i == 3 && data.b30) )
                                                                        Image.asset('assets/multidirectional_button/ALPHA/S1_003.png', width: 50, height: 50),
                                                                      if((i == 1 && data.b22) || (i == 2 && data.b40) || (i == 3 && data.b31) )
                                                                        Image.asset('assets/multidirectional_button/ALPHA/S1_004.png', width: 50, height: 50),
                                                                      if((i == 1 && data.b23) || (i == 2 && data.b41) || (i == 3 && data.b32) )
                                                                        Image.asset('assets/multidirectional_button/ALPHA/S1_005.png', width: 50, height: 50),
                                                                      if((i == 1 && data.b24) || (i == 2 && data.b42) || (i == 3 && data.b33) )
                                                                        Image.asset('assets/multidirectional_button/ALPHA/S1_006.png', width: 50, height: 50),
                                                                      if((i == 1 && data.b25) || (i == 2 && data.b43) || (i == 3 && data.b34) )
                                                                        Image.asset('assets/multidirectional_button/ALPHA/S1_007.png', width: 50, height: 50),
                                                                      if((i == 1 && data.b26) || (i == 2 && data.b44) || (i == 3 && data.b35) )
                                                                        Image.asset('assets/multidirectional_button/ALPHA/S1_008.png', width: 50, height: 50),
                                                                      if((i == 1 && data.b27) || (i == 2 && data.b45) || (i == 3 && data.b36) )
                                                                        Image.asset('assets/multidirectional_button/ALPHA/S1_009.png', width: 50, height: 50),

                                                                    ],
                                                                    )
                                                                    // i == 4 ? 
                                                                    //   Image.asset('assets/2-axis-button/ALPHA/S4_000.png', width: 50, height: 50) :
                                                                    //   Image.asset('assets/multidirectional_button/ALPHA/S1_000.png', width: 50, height: 50),
                                                                
                                                                ),
                                                          ]
                                                        )
                                                        )

                                                      ),
                                                  ]
                                                )
                                              ),
                                          if(_selectedGrip == 'ALPHA')
                                            for(var x in gripsConfig['ALPHA']['axis'])
                                              Positioned(
                                                top: x['offset'],
                                                left: 20,
                                                child: 
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    for(var i in x['buttons'])
                                                      Padding(
                                                        padding: EdgeInsets.all(10),
                                                        child: 
                                                        SizedBox(
                                                          width: 60,
                                                          child: Column(                                                          
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 10),
                                                              child: Text('${i}', style: TextStyle(fontSize: 13),),
                                                            ),
                                                            Container(
                                                              width: 50,
                                                              height: 100,
                                                              decoration: BoxDecoration(
                                                                color: Colors.transparent,
                                                                borderRadius: BorderRadius.circular(20),
                                                                shape: BoxShape.rectangle,
                                                                border:Border.all(
                                                                  color: Colors.white,// Border color
                                                                  width: 2.0,           // Border width
                                                                ),
                                                                
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0), 
                                                                child:  
                                                                Column(
                                                                  children: [
                                                                    if(i == 'RX')
                                                                      SizedBox(
                                                                        height: 42.5,
                                                                        width: 40,
                                                                        child:
                                                                          RotatedBox(
                                                                            quarterTurns: -1,
                                                                            child: LinearProgressIndicator(
                                                                              minHeight: 50.0,
                                                                              value: ((data.rxAxis - ((data.rxMax + data.rxMin) / 2)) / (data.rxMax - data.rxMin)).toDouble(),
                                                                              valueColor: AlwaysStoppedAnimation(Color.fromRGBO(193, 10, 10, 1)),
                                                                              backgroundColor: Colors.transparent,
                                                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15))
                                                                            ),
                                                                          ),
                                                                      ),
                                                                    if(i == 'RX')
                                                                      SizedBox(
                                                                        height: 42.5,
                                                                        width: 40,
                                                                        child:
                                                                          RotatedBox(
                                                                            quarterTurns: 1,
                                                                            child: LinearProgressIndicator(
                                                                              minHeight: 50.0,
                                                                              value: ((data.rxAxis - ((data.rxMax + data.rxMin) / 2)) / (data.rxMax - data.rxMin)) <= 0 ? ((data.rxAxis - ((data.rxMax + data.rxMin) / 2)) / (data.rxMax - data.rxMin)).abs().toDouble() : 0.0,
                                                                              valueColor: AlwaysStoppedAnimation(Color.fromRGBO(193, 10, 10, 1)),
                                                                              backgroundColor: Colors.transparent,
                                                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
                                                                            ),
                                                                          ),
                                                                      ),
                                                                    if(i == 'RY')
                                                                      SizedBox(
                                                                        height: 42.5,
                                                                        width: 40,
                                                                        child:
                                                                          RotatedBox(
                                                                            quarterTurns: -1,
                                                                            child: LinearProgressIndicator(
                                                                              minHeight: 50.0,
                                                                              value: ((data.ryAxis - ((data.ryMax + data.ryMin) / 2)) / (data.ryMax - data.ryMin)).toDouble(),
                                                                              valueColor: AlwaysStoppedAnimation(Color.fromRGBO(193, 10, 10, 1)),
                                                                              backgroundColor: Colors.transparent,
                                                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15))
                                                                            ),
                                                                          ),
                                                                      ),
                                                                    if(i == 'RY')
                                                                      SizedBox(
                                                                        height: 42.5,
                                                                        width: 40,
                                                                        child:
                                                                          RotatedBox(
                                                                            quarterTurns: 1,
                                                                            child: LinearProgressIndicator(
                                                                              minHeight: 50.0,
                                                                              value: ((data.ryAxis - ((data.ryMax + data.ryMin) / 2)) / (data.ryMax - data.ryMin)) <= 0 ? ((data.ryAxis - ((data.ryMax + data.ryMin) / 2)) / (data.ryMax - data.ryMin)).abs().toDouble() : 0.0,
                                                                              valueColor: AlwaysStoppedAnimation(Color.fromRGBO(193, 10, 10, 1)),
                                                                              backgroundColor: Colors.transparent,
                                                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
                                                                            ),
                                                                          ),
                                                                      ),
                                                                    if(i == 'Z')
                                                                      SizedBox(
                                                                        height: 42.5,
                                                                        width: 40,
                                                                        child:
                                                                          RotatedBox(
                                                                            quarterTurns: -1,
                                                                            child: LinearProgressIndicator(
                                                                              minHeight: 50.0,
                                                                              value: ((data.zAxis - ((data.zMax + data.zMin) / 2)) / (data.zMax - data.zMin)).toDouble(),
                                                                              valueColor: AlwaysStoppedAnimation(Color.fromRGBO(193, 10, 10, 1)),
                                                                              backgroundColor: Colors.transparent,
                                                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15))
                                                                            ),
                                                                          ),
                                                                      ),
                                                                    if(i == 'Z')
                                                                      SizedBox(
                                                                        height: 42.5,
                                                                        width: 40,
                                                                        child:
                                                                          RotatedBox(
                                                                            quarterTurns: 1,
                                                                            child: LinearProgressIndicator(
                                                                              minHeight: 50.0,
                                                                              value: ((data.zAxis - ((data.zMax + data.zMin) / 2)) / (data.zMax - data.zMin)) <= 0 ? ((data.zAxis - ((data.zMax + data.zMin) / 2)) / (data.zMax - data.zMin)).abs().toDouble() : 0.0,
                                                                              valueColor: AlwaysStoppedAnimation(Color.fromRGBO(193, 10, 10, 1)),
                                                                              backgroundColor: Colors.transparent,
                                                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
                                                                            ),
                                                                          ),
                                                                      ),
                                                                    if(i == 'Slider')
                                                                      SizedBox(
                                                                        height: 85,
                                                                        width: 40,
                                                                        child:
                                                                          RotatedBox(
                                                                            quarterTurns: 0,
                                                                            child: LinearProgressIndicator(
                                                                              minHeight: 90.0,
                                                                              value: ((data.sliderAxis - ((data.sliderMax + data.sliderMin) / 2)) / (data.sliderMax - data.sliderMin)).isFinite ? (data.sliderAxis - ((data.sliderMax + data.sliderMin) / 2)) / (data.sliderMax - data.sliderMin) : 0,
                                                                              valueColor: AlwaysStoppedAnimation(Color.fromRGBO(193, 10, 10, 1)),
                                                                              backgroundColor: Colors.transparent,
                                                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15))
                                                                            ),
                                                                          ),
                                                                      ),
                                                                  ]
                                                                )
                                                              ),
                                                            )
                                                          ]
                                                        )
                                                        )

                                                      ),
                                                  ]
                                                )
                                              ),
                                          if(_selectedGrip == 'ALPHA')
                                            for(var x in gripsConfig['ALPHA']['buttons'])
                                              Positioned(
                                                top: x['offset'],
                                                left: 20,
                                                child: 
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    for(var i in x['buttons'])
                                                      Padding(
                                                        padding: EdgeInsets.all(10),
                                                        child: 
                                                        SizedBox(
                                                          width: 60,
                                                          child: Column(                                                          
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 10),
                                                              child: Text('Button ${i}', style: TextStyle(fontSize: 13),),
                                                            ),
                                                            Container(
                                                                  width: 50,
                                                                  height: 50,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.transparent,
                                                                    shape: BoxShape.circle,
                                                                    border:Border.all(
                                                                      color: Colors.white,// Border color
                                                                      width: 2.0,           // Border width
                                                                    ),
                                                                    boxShadow: [
                                                                      if(i == 1 && data.b9)
                                                                        const BoxShadow(
                                                                          color: Color.fromRGBO(193, 10, 10, 1),
                                                                          blurRadius: 20.0,
                                                                          spreadRadius: 0.0,
                                                                          offset: Offset(0.0, 0.0),
                                                                          blurStyle: BlurStyle.outer
                                                                        ),
                                                                      if(i == 2 && data.b8)
                                                                        const BoxShadow(
                                                                          color: Color.fromRGBO(193, 10, 10, 1),
                                                                          blurRadius: 20.0,
                                                                          spreadRadius: 0.0,
                                                                          offset: Offset(0.0, 0.0),
                                                                          blurStyle: BlurStyle.outer
                                                                        ),
                                                                      if(i == 3 && data.b7)
                                                                        const BoxShadow(
                                                                          color: Color.fromRGBO(193, 10, 10, 1),
                                                                          blurRadius: 20.0,
                                                                          spreadRadius: 0.0,
                                                                          offset: Offset(0.0, 0.0),
                                                                          blurStyle: BlurStyle.outer
                                                                        ),
                                                                      if(i == 4 && data.b10)
                                                                        const BoxShadow(
                                                                          color: Color.fromRGBO(193, 10, 10, 1),
                                                                          blurRadius: 20.0,
                                                                          spreadRadius: 0.0,
                                                                          offset: Offset(0.0, 0.0),
                                                                          blurStyle: BlurStyle.outer
                                                                        ),
                                                                      if(i == 5 && data.b11)
                                                                        const BoxShadow(
                                                                          color: Color.fromRGBO(193, 10, 10, 1),
                                                                          blurRadius: 20.0,
                                                                          spreadRadius: 0.0,
                                                                          offset: Offset(0.0, 0.0),
                                                                          blurStyle: BlurStyle.outer
                                                                        ),
                                                                      if(i == 6 && data.b12)
                                                                        const BoxShadow(
                                                                          color: Color.fromRGBO(193, 10, 10, 1),
                                                                          blurRadius: 20.0,
                                                                          spreadRadius: 0.0,
                                                                          offset: Offset(0.0, 0.0),
                                                                          blurStyle: BlurStyle.outer
                                                                        ),
                                                                      if(i == 7 && data.b2)
                                                                        const BoxShadow(
                                                                          color: Color.fromRGBO(193, 10, 10, 1),
                                                                          blurRadius: 20.0,
                                                                          spreadRadius: 0.0,
                                                                          offset: Offset(0.0, 0.0),
                                                                          blurStyle: BlurStyle.outer
                                                                        ),
                                                                      if(i == 8 && data.b13)
                                                                        const BoxShadow(
                                                                          color: Color.fromRGBO(193, 10, 10, 1),
                                                                          blurRadius: 20.0,
                                                                          spreadRadius: 0.0,
                                                                          offset: Offset(0.0, 0.0),
                                                                          blurStyle: BlurStyle.outer
                                                                        ),
                                                                      if(i == 9 && data.b14)
                                                                        const BoxShadow(
                                                                          color: Color.fromRGBO(193, 10, 10, 1),
                                                                          blurRadius: 20.0,
                                                                          spreadRadius: 0.0,
                                                                          offset: Offset(0.0, 0.0),
                                                                          blurStyle: BlurStyle.outer
                                                                        ),
                                                                      if(i == 10 && data.b5)
                                                                        const BoxShadow(
                                                                          color: Color.fromRGBO(193, 10, 10, 1),
                                                                          blurRadius: 20.0,
                                                                          spreadRadius: 0.0,
                                                                          offset: Offset(0.0, 0.0),
                                                                          blurStyle: BlurStyle.outer
                                                                        ),
                                                                      if(i == 11 && data.b4)
                                                                        const BoxShadow(
                                                                          color: Color.fromRGBO(193, 10, 10, 1),
                                                                          blurRadius: 20.0,
                                                                          spreadRadius: 0.0,
                                                                          offset: Offset(0.0, 0.0),
                                                                          blurStyle: BlurStyle.outer
                                                                        ),
                                                                      if(i == 12 && data.b3)
                                                                        const BoxShadow(
                                                                          color: Color.fromRGBO(193, 10, 10, 1),
                                                                          blurRadius: 20.0,
                                                                          spreadRadius: 0.0,
                                                                          offset: Offset(0.0, 0.0),
                                                                          blurStyle: BlurStyle.outer
                                                                        ),
                                                                    ],
                                                                  ),
                                                                  
                                                                  child: Padding(
                                                                    padding: EdgeInsets.all(5), 
                                                                    child: Container(
                                                                      width: 40,
                                                                      height: 40,
                                                                      decoration: const BoxDecoration(
                                                                        color: Color.fromRGBO(193, 10, 10, 1),
                                                                        shape: BoxShape.circle,
                                                                      )
                                                                    )
                                                                  )
                                                                
                                                                ),
                                                          ]
                                                        )
                                                        )

                                                      ),
                                                  ]
                                                )
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
                        color: Color.fromARGB(255, 24, 24, 24),
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
                                  color: Colors.transparent,
                                ),

                                DropdownButton<String>(
                                  hint: Text('Select grip'),
                                  value: _selectedGrip,
                                  items: _grips.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _selectedGrip = val.toString();
                                      if(val.toString() == 'EVO') {
                                        rust_request('selegrip EVO Grip L', 0, 0, 0, 0, RustOperation.Update);
                                        rust_request('apply', 0, 0, 0, 0, RustOperation.Update);
                                      } 
                                      if(val.toString() == 'ALPHA') {
                                        rust_request('selegrip VPC Alpha Prime L', 0, 0, 0, 0, RustOperation.Update);
                                        rust_request('apply', 0, 0, 0, 0, RustOperation.Update);
                                      }
                                      if(val.toString() == 'THRUSTMASTER') {
                                        rust_request('selegrip Thrustmaster ', 0, 0, 0, 0, RustOperation.Update);
                                        rust_request('apply', 0, 0, 0, 0, RustOperation.Update);
                                      }
                                      
                                    });
                                  },
                                ),

                                const Divider(
                                  height: 20,
                                  thickness: 5,
                                  indent: 20,
                                  endIndent: 0,
                                  color: Colors.transparent,
                                ),

                                // Text('${(data.sliderAxis - ((data.sliderMax + data.sliderMin) / 2)) / (data.sliderMax - data.sliderMin) != double.infinity ? (data.sliderAxis - ((data.sliderMax + data.sliderMin) / 2)) / (data.sliderMax - data.sliderMin) : 0} '),
                                // Text('${data.rxMin}-${data.rxMax} : ${data.rx} (${data.rxAxis})'),
                                // Text('${data.ryMin}-${data.ryMax} : ${data.ry}'),
                                // Text('${data.idGrib}'),
                                // Text('${data.buttons}'),
                                // Text('${data.baseName}'),
                                // Text('${realX} ${realY}'),
                                // Text('${alphaButtons}'),
                                // Text('${alphaButtons.indexOf("S1")}'),
                                Text('01-05: ${data.b1} ${data.b2} ${data.b3} ${data.b4} ${data.b5}'),
                                Text('06-10: ${data.b6} ${data.b7} ${data.b8} ${data.b9} ${data.b10}'),
                                Text('11-15: ${data.b11} ${data.b12} ${data.b13} ${data.b14} ${data.b15}'),
                                Text('16-20: ${data.b16} ${data.b17} ${data.b18} ${data.b19} ${data.b20}'),
                                Text('21-25: ${data.b21} ${data.b22} ${data.b23} ${data.b24} ${data.b25}'),
                                Text('26-30: ${data.b26} ${data.b27} ${data.b28} ${data.b29} ${data.b30}'),
                                Text('31-35: ${data.b31} ${data.b32} ${data.b33} ${data.b34} ${data.b35}'),
                                Text('36-40: ${data.b36} ${data.b37} ${data.b38} ${data.b39} ${data.b40}'),
                                Text('41-45: ${data.b41} ${data.b42} ${data.b43} ${data.b44} ${data.b45}'),
                                Text('46-49: ${data.b46} ${data.b47} ${data.b48} ${data.b49}'),

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
