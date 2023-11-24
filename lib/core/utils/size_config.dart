import 'package:flutter/material.dart';

class SizeConfig {
  static double getScreenWidth(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    if (size.width < 600) {
      return size.width;
    } else {
      return size.height;
    }
  }

  static double getScreenHeight(BuildContext context) {   Size size=MediaQuery.of(context).size;
    if (size.width < 600) {
      return size.height;
    } else {
      return size.width;
    }
  }

  static Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}
