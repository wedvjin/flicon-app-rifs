import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:flicon/messages/device_info.pb.dart' as deviceInfo;
import 'package:flicon/messages/report_in_message.pb.dart' as reportInMessage;
import 'package:flicon/messages/increasing_number.pb.dart'
    as increasingNumbers;
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'dart:typed_data';

import 'package:flicon/pages/search_page.dart';
import 'package:flicon/pages/settings_page.dart';

GoRouter router() {
  return GoRouter(
    initialLocation: '/search',
    routes: [
      GoRoute(
        path: '/search',
        builder: (context, state) => const Search(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const Home(),
      ),
    ],
  );
}

void main() async {
  // Wait for Rust initialization to be completed first.
  await RustInFlutter.ensureInitialized();  
  runApp(const FliconApp());
}

class FliconApp extends StatefulWidget {
  const FliconApp({super.key});

  @override
  State<FliconApp> createState() => _FliconAppState();
}

class _FliconAppState extends State<FliconApp> {
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

  Future<void> rust_request(message, value1, value2, value3, value4, RustOperation operation) async {
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
    setState(() {
      _contoller = responseMessage.outputString;
    });
  }

  void apply() {
    final c = color.toColor();
    rust_request('led', c.red, c.green, c.blue, 0, RustOperation.Update);
    rust_request('apply', 0, 0, 0, 0, RustOperation.Update);
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
                  var buff = reportInMessage.ReportInMessage(data: rustSignal.message);
                  final ByteData byteData = ByteData.sublistView(buff.writeToBuffer());
               
                  return Column(
                    children: [
                      Text(rustSignal.message.toString()),
                      Text("1: ${byteData.getUint16(1, Endian.big)}"),
                      Text("2: ${byteData.getUint16(2)}"),
                      Text("3: ${byteData.getUint16(3)}"),
                      Text("4: ${byteData.getUint16(4)}"),
                    ]
                  );
                }
              },
            ),
            Text(_contoller),
            WheelPicker(
              color: color,
              onChanged: (value) {         
                setState(() {
                  color = value;
                });
              },
            ),
            Text("${color.toColor().red} ${color.toColor().green} ${color.toColor().blue}"),
            ElevatedButton(
              onPressed: apply, 
              child: const Text("Apply")
            )
          ],
        ),
      ),
      // 
    );
  }
}