import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:flicon/messages/report_in.pb.dart' as  report_in;
import 'package:example_app/messages/device_info.pb.dart'
    as deviceInfo;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // `StreamBuilder` listens to a stream
            // and rebuilds the widget accordingly.
            StreamBuilder<RustSignal>(
              // Receive signals from Rust
              // with `rustBroadcaster` from `rust_in_flutter.dart`,
              // For better performance, filter signals
              // by checking the `resource` field with the `where` method.
              // This approach allows the builder to rebuild its widget
              // only when there are signals
              // related to a specific Rust resource it is interested in.
              stream: rustBroadcaster.stream.where((rustSignal) {
                return rustSignal.resource == report_in.ID;
              }),
              builder: (context, snapshot) {
                print(snapshot.error.toString());
                print(snapshot.data.toString());
                // If the app has just started and widget is built
                // without receiving a Rust signal,
                // the snapshot's data will be null.
                final rustSignal = snapshot.data;
                if (rustSignal == null) {
                  // Return a black container if the received data is null.
                  return Text(snapshot.data.toString());
                } else {
                  // Return an image container if some data is received.
                  return Text(snapshot.data.toString());
                }
              },
            ),
          ],
        ),
      ),
      // 
    );
  }
}