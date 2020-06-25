import 'package:flutter/material.dart';

ThemeData appTheme(){
  return ThemeData(
    fontFamily: 'Roboto',
    primaryColor: Color(0xff252847),
    
    splashColor: Color(0xffB4B7D7),
    
    textTheme: TextTheme(
      headline5: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
      headline3: TextStyle(color: Color(0xff252847), fontWeight: FontWeight.bold, fontSize: 46),
    )
  );
}