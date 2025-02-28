import 'package:flutter/material.dart';

extension Responsive on BuildContext {
  double screenWidth(double value) {
    return MediaQuery.of(this).size.width * value;
  }

  double screenHeight(double value) {
    return MediaQuery.of(this).size.height * value;
  }
}