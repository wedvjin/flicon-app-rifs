import 'package:flicon/widgets/settings/base_rotation.dart';
import 'package:flicon/widgets/settings/base_calibration.dart';
import 'package:flicon/widgets/settings/led_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:math' as math;




const List<String> profiles = <String>[
  'Profile 1',
  'Profile 2',
  'Profile 3',
  'Profile 4'
];

List<double> getChartData() {
    return <double>[
      0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0,
      1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0,
      1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0,
      1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0,
    ];
  }



class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String profileListValue = profiles.first;
  HSVColor color = HSVColor.fromColor(Colors.blue);
  bool _ledExpanded = false;
  List<double> chartData = [1];

  @override
  void initState() {
    chartData = getChartData();
    Timer.periodic(const Duration(milliseconds: 300), updateDataSource);
    super.initState();
  }

  int time = 10;
  void updateDataSource(Timer timer) {
    chartData.add((math.Random().nextInt(5) + 0));
    chartData.removeAt(0);
  }

  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];

  onColorChanged(HSVColor color) {
    this.color = color;
  }

  @override
  Widget build(BuildContext context) {

    return Column(children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: DropdownMenu<String>(
                enableFilter: false,
                enableSearch: false,
                width: 315,
                label: const Text("Profile"),
                leadingIcon: const Icon(Icons.folder),
                inputDecorationTheme: const InputDecorationTheme(
                  filled: true,
                  fillColor: Colors.black,
                  outlineBorder: BorderSide(color: Color.fromRGBO(193, 10, 10, 1)),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                ),
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    profileListValue = value!;
                  });
                },
                dropdownMenuEntries:
                    profiles.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ))
      ]),
      Row(children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(right: 2),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                foregroundColor: Colors.white),
            child: const Text('Load'),
            onPressed: () => {},
          ),
        )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 2),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                  foregroundColor: Colors.white),
              child: const Text('Save'),
              onPressed: () => {},
            ),
          ),
        )
      ]),
      const Divider(
        height: 30,
        thickness: 5,
        indent: 20,
        endIndent: 0,
        color: Colors.black12,
      ),

    ]);
  }
}

/*

  int _counter = 0;
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;
  RangeValues _currentRangeValues = const RangeValues(228, 420);
  Color currentColor = Colors.amber;
  List<Color> currentColors = [Colors.yellow, Colors.green];
  List<Color> colorHistory = [];

  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColors(List<Color> colors) => setState(() => currentColors = colors);

  final SfRangeValues _inactiveRangeSliderValue =
      const SfRangeValues(20.0, 80.0);

  final SfRangeValues _activeRangeSliderValue = const SfRangeValues(20.0, 80.0);

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }



  @override
  void initState() {
    chartData = getChartData();
    Timer.periodic(const Duration(milliseconds: 300), updateDataSource);
    super.initState();
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 2),
      LiveData(1, 4),
      LiveData(2, 3),
      LiveData(3, 4),
      LiveData(4, 3),
      LiveData(5, 1),
      LiveData(6, 0),
      LiveData(7, 4),
      LiveData(8, 6),
      LiveData(9, 3),
      LiveData(10, 2),
      LiveData(11, 3),
      LiveData(12, 2),
      LiveData(13, 1),
      LiveData(14, 2),
      LiveData(15, 3),
      LiveData(16, 6),
      LiveData(17, 7),
      LiveData(18, 4)
    ];
  }


List<int> hsvToRGB(HSVColor color) {
  //convert to color
  final c = color.toColor();
  return [c.red, c.blue, c.green];
}
class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final num speed;
}
  int time = 10;
  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, (math.Random().nextInt(5) + 0)));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  }

  late int ledR = 1;
  late int ledG = 1;
  late int ledB = 1;


  HSVColor color = HSVColor.fromColor(Colors.blue);
  onColorChanged(HSVColor color) {
    this.color = color;
    //await storage.setItem('ledR', hsvToRGB(color)[0]);
    //await storage.setItem('ledG', hsvToRGB(color)[0]);
    //await storage.setItem('ledB', hsvToRGB(color)[2]);

  }

ListView(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 20),
                        child: Text("Click on any button to continue setup", style: TextStyle(color: Colors.white,))
                      ),
                      SfCartesianChart(
                        series: <LineSeries<LiveData, int>>[
                          LineSeries<LiveData, int>(
                            onRendererCreated: (ChartSeriesController controller) {
                              _chartSeriesController = controller;
                            },
                            dataSource: chartData,
                            color: Color.fromRGBO(22, 232, 3, 1),
                            xValueMapper: (LiveData sales, _) => sales.time,
                            yValueMapper: (LiveData sales, _) => sales.speed,
                          )
                        ],
                        primaryXAxis: NumericAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                          interval: 3,
                          title: AxisTitle(text: 'Tension')
                        ),
                        primaryYAxis: NumericAxis(
                          axisLine: const AxisLine(width: 0),
                          majorTickLines: const MajorTickLines(size: 0),
                        ),
                      ),
                      RangeSlider(
                        values: _currentRangeValues,
                        max: 500,
                        divisions: 5,
                        labels: RangeLabels(
                          _currentRangeValues.start.round().toString(),
                          _currentRangeValues.end.round().toString(),
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _currentRangeValues = values;
                          });
                        },
                      ),
                      WheelPicker(
                        color: color,
                        onChanged: (value) => super.setState(
                           () => onColorChanged(value),
                        ),
                      )

                    ],
                  ),
                  */