import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:flicon/messages/device_info.pb.dart' as deviceInfo;
import 'package:flicon/messages/report_in_message.pb.dart' as reportInMessage;
import 'package:flicon/messages/increasing_number.pb.dart'
    as increasingNumbers;
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';


void main() async {
  // Wait for Rust initialization to be completed first.
  await RustInFlutter.ensureInitialized();  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appLifecycleListener = AppLifecycleListener(
    onExitRequested: () async {
      await RustInFlutter.ensureFinalized();
      return AppExitResponse.exit;
    },
  );


  @override
  void dispose() {
    _appLifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RIF Example',
      theme: ThemeData(
        useMaterial3: true,
        brightness: MediaQuery.platformBrightnessOf(context),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _contoller = 'unknown';

  Future<void> btn(message, value1, value2, value3, value4) async {
    final requestMessage = deviceInfo.SetValues(
      target: message,
      value1: value1,
      value2: value2,
      value3: value3,
      value4: value4,
    );
    var rustResponse = await requestToRust(RustRequest(
      resource: deviceInfo.ID,
      operation: RustOperation.Read,
      message: requestMessage.writeToBuffer(),
    ));
    var responseMessage =
        deviceInfo.ReadResponse.fromBuffer(
          rustResponse.message!,
        );
    setState(() {
      _contoller = responseMessage.outputString;
    });
  }

  HSVColor color = HSVColor.fromColor(Colors.blue);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<RustSignal>(
              stream: rustBroadcaster.stream.where((rustSignal) {
                return rustSignal.resource == reportInMessage.ID;
              }),
              builder: (context, snapshot) {
                final rustSignal = snapshot.data;
                if (rustSignal == null) {
                  return Text("No stream");
                } else {
                  return Text(rustSignal.message.toString());
                }
              },
            ),
            Text(_contoller),
            WheelPicker(
              color: color,
              onChanged: (value) async { 
                final c = color.toColor();
                await btn('led', c.red, c.green, c.blue, 0);
                setState(() {
                  color = value;
                });
              },
            ),
            Text("${color.toColor().red} ${color.toColor().green} ${color.toColor().blue}"),
          ],
        ),
      ),
      // 
    );
  }
}