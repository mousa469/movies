import 'package:flutter/material.dart';

extension CustomePadding on Widget {
  Widget horizontalPadding(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: value),
      child: this,
    );
  }

  Widget verticalPadding(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: value),
      child: this,
    );
  }

  Widget symmetricPadding(double horizontalValue, double verticalValue) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: verticalValue,
        horizontal: horizontalValue,
      ),
      child: this,
    );
  }

  Widget customePadding(double left, double right, double top, double bottom) {
    return Padding(
      padding:
          EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: this,
    );
  }
}
