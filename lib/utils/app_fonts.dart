import 'package:flutter/material.dart';

TextStyle montserratTextStyle(
    {Color color = Colors.black,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal}) {
  return TextStyle(
    fontFamily: 'Montserrat',
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}

TextStyle robotoTextStyle(
    {Color color = Colors.black,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal}) {
  return TextStyle(
    fontFamily: 'Roboto',
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}
