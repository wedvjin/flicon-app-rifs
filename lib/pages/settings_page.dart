import 'package:flicon/models/vars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flicon/widgets/controller.dart';
import 'package:flicon/widgets/settings.dart';




class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  
  @override
  Widget build(BuildContext context) {
    var varsRead = context.read<VarsModel>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
      ])),
    );
  }
}