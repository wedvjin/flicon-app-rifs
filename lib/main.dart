import 'dart:ui';
import 'package:FC_Technologies/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:FC_Technologies/messages/device_info.pb.dart' as deviceInfo;
import 'package:FC_Technologies/messages/report_message.pb.dart' as reportMessage;
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';

import 'package:FC_Technologies/pages/search_page.dart';
import 'package:FC_Technologies/pages/settings_page.dart';
import 'package:window_manager/window_manager.dart';

GoRouter router() {
  return GoRouter(
    initialLocation: '/loading',
    routes: [
      GoRoute(
        path: '/loading',
        builder: (context, state) => const LoadingPage(),
      ),
      GoRoute(
        path: '/main',
        builder: (context, state) => const MyHomePage(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const Search(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingPage(),
      ),
    ],
  );
}

void main() async {
  // Wait for Rust initialization to be completed first.
  await RustInFlutter.ensureInitialized();  
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: Size(1000, 650),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    windowButtonVisibility: true,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setTitle('FC Technologies');
    await windowManager.setResizable(false);
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const FCTechnologiesApp());
}

class FCTechnologiesApp extends StatefulWidget {
  const FCTechnologiesApp({super.key});

  @override
  State<FCTechnologiesApp> createState() => _FCTechnologiesAppState();
}

class _FCTechnologiesAppState extends State<FCTechnologiesApp> {
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
    return MaterialApp.router(
        title: 'EVO Flight Controller',
        theme: AppTheme().main,
        routerConfig: router(),
      );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
    @override
  Widget build(BuildContext context) {  

    Future.delayed(Duration(seconds: 3)).then((value) => {
      context.go('/settings')
    });
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.gif', width: 100,)
          ]
        )
      )
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
String path = '...';

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
    rust_request('discalibratehandle', 0, 0, 0, 0, RustOperation.Update);
    rust_request('discalibratebase', 0, 0, 0, 0, RustOperation.Update);
    rust_request('apply', 0, 0, 0, 0, RustOperation.Update);
    rust_request('setled', c.red, c.green, c.blue, 0, RustOperation.Update);
    rust_request('apply', 0, 0, 0, 0, RustOperation.Update);
    rust_request('save', 0, 0, 0, 0, RustOperation.Update);
  }

  void toggleLR() {
    rust_request('discalibratehandle', 0, 0, 0, 0, RustOperation.Update);
    rust_request('discalibratebase', 0, 0, 0, 0, RustOperation.Update);
    rust_request('apply', 0, 0, 0, 0, RustOperation.Update);
    rust_request('togglelr', 0, 0, 0, 0, RustOperation.Update);
    rust_request('apply', 0, 0, 0, 0, RustOperation.Update);
    rust_request('save', 0, 0, 0, 0, RustOperation.Update);
    rust_request('apply', 0, 0, 0, 0, RustOperation.Update);
  }

  void showPath() {
    rust_request('upgradef', 0, 0, 0, 0, RustOperation.Update);
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
                return rustSignal.resource == reportMessage.ID;
              }),
              builder: (context, snapshot) {
                final rustSignal = snapshot.data;
                if (rustSignal == null) {
                  return const Text("No reportMessage stream");
                } else {
                  var dd = reportMessage.ReportMessage.fromBuffer(rustSignal.message as List<int>);
                  //var buff = reportInMessage.ReportInMessage(data: rustSignal.message);
                  //final ByteData byteData = ByteData.sublistView(buff.writeToBuffer());
               
                  return Column(
                    children: [
                      //Text("${dd.rx} ${dd.x} ${dd.y}"),
                      Text("${dd.ledR} ${dd.ledG} ${dd.ledB}"),
                      Text("${dd.controlByte}"),
                      // Text("1: ${byteData.getUint8(1)}"),
                      // Text("2: ${byteData.getUint16(2)}"),
                      // Text("3: ${byteData.getUint16(3)}"),
                      // Text("4: ${byteData.getUint16(4)}"),
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
            ),
            ElevatedButton(
              onPressed: toggleLR, 
              child: const Text("Toggle L/R")
            ),
            ElevatedButton(
              onPressed: () => {
                context.go('/settings')
              },
              child: const Text("Go to settings")
            )
          ],
        ),
      ),
      // 
    );
  }
}