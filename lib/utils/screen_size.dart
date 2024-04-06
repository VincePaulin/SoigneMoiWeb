import 'package:flutter/material.dart';

class ScreenSizeUtil {
  static bool isSmallScreen(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return screenSize.width <= 1200;
  }
}
