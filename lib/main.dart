import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:flicon/messages/device_info.pb.dart' as deviceInfo;

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
      // Terminate Rust tasks before closing the Flutter app.
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

  Future<void> btn() async {
    var requestMessage = deviceInfo.ReadRequest(
      inputNumbers: [1],
      inputString: 'n',
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
    print(responseMessage.outputNumbers);
    print(responseMessage.outputString);

    setState(() {
      _contoller = responseMessage.outputString;
    });
  }

  @override
  Widget build(BuildContext context) {
    deviceInfo.ReadRequest requestMessage;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
            ElevatedButton(
              onPressed: btn,
              child: const Text("Request to Rust")
            ),
            Text(_contoller),
          ],
        ),
      ),
      // 
    );
  }
}