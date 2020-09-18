import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  MaterialColor _primaryColor = Colors.blue;

  MaterialColor get primaryColor => this._primaryColor;

  set primaryColor(MaterialColor _primaryColor) {
    this._primaryColor = _primaryColor;
    notifyListeners();
  }

  MaterialAccentColor _accentColor = Colors.blueAccent;

  MaterialAccentColor get accentColor => this._accentColor;

  set accentColor(MaterialAccentColor _accentColor) {
    this._accentColor = _accentColor;
    notifyListeners();
  }
}
