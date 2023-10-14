import 'package:flicon/models/settings.dart';
import 'package:flutter/foundation.dart';

class VarsModel extends ChangeNotifier {
  late SettingsModel _settings;

  final List<int> _itemIds = [];
  int currentItem = 0;
  List<int> currentRGB = [0, 0 ,0];

  SettingsModel get settings => _settings;

  set settings(SettingsModel newSettings) {
    _settings = newSettings;
    notifyListeners();
  }

  void add(Setting item) {
    currentItem = item.id;
    notifyListeners();
  }

  void remove() {
    currentItem = 0;
    notifyListeners();
  }

  void addRGB(RGB item) {
    currentRGB = [item.r, item.g, item.b];
    notifyListeners();
  }

  void removeRGB() {
    currentRGB = [0,0,0];
    notifyListeners();
  }
}