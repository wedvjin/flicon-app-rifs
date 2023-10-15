import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flicon/messages/report_message.pb.dart' as reportMessage;


class LedColorPicker extends StatefulWidget {
  final reportMessage.ReportMessage data;

  const LedColorPicker({Key? key, required this.data}) : super(key: key);

  @override
  State<LedColorPicker> createState() => _LedColorPickerState();
}

class _LedColorPickerState extends State<LedColorPicker> {


  @override
  Widget build(BuildContext context) {
     
    HSVColor color = HSVColor.fromColor(Color.fromRGBO(widget.data.ledR, widget.data.ledG, widget.data.ledB, 1));

    return Column(
      children: [
        Text("${widget.data.ledR} ${widget.data.ledG} ${widget.data.ledB}"),
        WheelPicker(
          color: color,
          onChanged: (value){ 
            setState(() {
              color = value;
              final c = color.toColor();
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                foregroundColor: Colors.white),
            child: const Text('Apply & Save'),
            onPressed: () => {},
          ),
        )
      ]);
    }
}