import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Colors.black,
      body: Stack( 
        children: [
          Center(child: Lottie.asset('assets/4scqCEpLd4.json', height: 200,)),
          const Center(child: Text('Device not found.')),
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