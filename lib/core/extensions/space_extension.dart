import 'package:flutter/material.dart';

extension space on int {
  Widget verticalSpace() {
    return SizedBox(
      height: toDouble(),
    );
  }

  Widget horizontalSpace() {
    return SizedBox(
      width: toDouble(),
    );
  }
}
