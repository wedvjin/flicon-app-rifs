import 'package:flutter/material.dart';

class HWUpgrade extends StatefulWidget {
  const HWUpgrade({super.key});

  @override
  State<HWUpgrade> createState() => _HWUpgradetate();
}

class _HWUpgradetate extends State<HWUpgrade> {

  @override
  Widget build(BuildContext context) {

    return  const Scaffold(
      backgroundColor: Colors.black,
      body: Stack( 
        children: [
          Center(child: Text('Please do not unpulg device. Wait until upgrade is complete.')),
      ])
      
    );
  }
 }