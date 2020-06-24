import 'package:flutter/material.dart';

class CommonProvider extends ChangeNotifier{
  String _selectedRouteName;
  String get selectedRouteName => _selectedRouteName;
  set selectedRouteName(String val) {
    _selectedRouteName = val;
    notifyListeners();
  }

 }