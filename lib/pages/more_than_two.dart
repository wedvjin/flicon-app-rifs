import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class MoreThanTwo extends StatefulWidget {
  const MoreThanTwo({super.key});

  @override
  State<MoreThanTwo> createState() => _MoreThanTwoState();
}

class _MoreThanTwoState extends State<MoreThanTwo> {

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Colors.black,
      body: Stack( 
        children: [
          Center(child: Lottie.asset('assets/more-than-two.json', height: 500,)),
          Positioned(top: 350, left: 410, child: Center(child: Text('Connect one device at a time.'))),
          Positioned(
            bottom: 30,
            left: 400,
            width: 200,
            child:  ElevatedButton(
            
            style: ElevatedButton.styleFrom(
                maximumSize: const Size(200, 50),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                foregroundColor: Colors.white),
            child: const Text('Scan again'),
            onPressed: () => {
              context.go('/settings')
            },
          ),
          )
      ])
      
    );
  }
 }