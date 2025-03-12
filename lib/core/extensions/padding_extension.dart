import 'package:flutter/material.dart';

extension CustomePadding on Widget {
  Widget horizontalPadding({required double value}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: value),
      child: this,
    );
  }

  Widget verticalPadding({required double value}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: value),
      child: this,
    );
  }

  Widget symmetricPadding({required double horizontalValue, required  double verticalValue}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: verticalValue,
        horizontal: horizontalValue,
      ),
      child: this,
    );
  }

  Widget customePadding({ double ? left,  double? right,   double ? top,  double ?bottom}) {
    return Padding(
      padding:
          EdgeInsets.only(left: left ?? 0, right: right ?? 0, top: top ?? 0, bottom: bottom ?? 0),
      child: this,
    );
  }
}
