import 'dart:typed_data';

import 'package:flicon/models/vars.dart';
import 'package:flicon/streams/rust_signal_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flicon/widgets/controller.dart';
import 'package:flicon/widgets/settings.dart';
import 'package:rust_in_flutter/rust_in_flutter.dart';

class SettingsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var reportInMessage;
    return  MultiProvider(
      providers: [
        StreamProvider<RustSignal>(
          create: (context) => RustSignalProvider(reportInMessage.ID).rustSignalStream,
          initialData: RustSignal(resource: 0, message: Uint8List(0)),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Row(
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
                      )),
                      child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Stack(alignment: AlignmentDirectional.center, children: [
                            Positioned(child: Controllers()),
                          ])))),
              Expanded(
                  flex: 1,
                  child: Container(
                      color: Colors.black,
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                          child: ListView(
                            children: const [Settings()],
                          )))),
            ]
          )
        ),
      )
    );
  }
}