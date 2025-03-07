import 'package:flutter/material.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});
  static const String id = "layout";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Layout",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
