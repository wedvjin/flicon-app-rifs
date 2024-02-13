import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:rust_in_flutter/rust_in_flutter.dart';
import 'package:FC_Technologies/messages/device_info.pb.dart' as deviceInfo;

class MoreThanTwo extends StatefulWidget {
  const MoreThanTwo({super.key});

  @override
  State<MoreThanTwo> createState() => _MoreThanTwoState();
}

class _MoreThanTwoState extends State<MoreThanTwo> {

  Future<deviceInfo.ReadResponse> rust_request(message, value1, value2, value3, value4, RustOperation operation) async {
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
    return responseMessage;
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Colors.black,
      body: Stack( 
        children: [
          Center(child: Lottie.asset('assets/more-than-two.json', height: 500,)),
          const Positioned(top: 350, left: 410, child: Center(child: Text('Connect one device at a time.'))),
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
              rust_request('scanagain', 0, 0, 0, 0, RustOperation.Update)
            },
          ),
          )
      ])
      
    );
  }
 }