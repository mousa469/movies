import 'package:flutter/material.dart';

extension space on num {
  Widget verticalSpace(double value) {
    return SizedBox(
      height: value,
    );
  }

  Widget horizontalSpace(double value) {
    return SizedBox(
      width: value,
    );
  }
}
