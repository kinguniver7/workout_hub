import 'package:flutter/material.dart';

ThemeData appTheme(){
  return ThemeData(
    fontFamily: 'Roboto',
    primaryColor: Color(0xff252847),
    textTheme: TextTheme(
      headline5: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)
    )
  );
}