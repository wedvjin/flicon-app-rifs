import 'package:flutter/material.dart';

class SettingsModel {
  Setting getById(int id) => Setting(id);
  Setting getByPosition(int position) {
    return getById(position);
  }
}

@immutable
class Setting {
  final int id;
  const Setting(this.id);

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Setting && other.id == id;
}

@immutable
class RGB {
  final int r;
  final int g;
  final int b;

  const RGB(this.r, this.g, this.b);

  @override
  int get hashCode => (r + g + b);

  @override
  bool operator ==(Object other) => other is RGB && other.r == r && other.g == g && other.b == b;
}