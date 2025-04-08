import 'package:flutter/material.dart';

class BrightnessController extends ChangeNotifier {
  BrightnessController([Brightness brightness = Brightness.dark]) {
    _brightness = brightness;
  }

  late Brightness _brightness;

  bool get isDark => _brightness == Brightness.dark;

  void toggle() {
    _brightness =
        _brightness == Brightness.light ? Brightness.dark : Brightness.light;
    notifyListeners();
  }
}
