import 'package:flicon/models/settings.dart';
import 'package:flicon/models/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class LedColorPicker extends StatefulWidget {
  const LedColorPicker({Key? key}) : super(key: key);

  @override
  State<LedColorPicker> createState() => _LedColorPickerState();
}

class _LedColorPickerState extends State<LedColorPicker> {

  HSVColor color = HSVColor.fromColor(Colors.blue);

  @override
  Widget build(BuildContext context) {
    var varsWatch = context.watch<VarsModel>();

    return Column(
      children: [
        WheelPicker(
          color: color,
          onChanged: (value){ 
            setState(() {
              varsWatch.removeRGB();
              color = value;
              final c = color.toColor();
              varsWatch.addRGB(RGB(c.red, c.green, c.blue));
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