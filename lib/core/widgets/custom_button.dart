import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color? color;
  final Widget? child;
  final VoidCallback? onPressed;

  const CustomElevatedButton({
    Key? key,
    this.color,
    this.child,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.blue, // Default color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Default radius
          ),
        ),
        onPressed: onPressed ?? () {}, // Default empty function
        child: child,
      ),
    );
  }
}
