import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color? color;
  final String? text;
  final VoidCallback? onPressed;

  const CustomElevatedButton({
    Key? key,
    this.color,
    this.text,
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
        child: Text(text ?? "Button", // Default text
            style: AppStyles.textStyle20SemiBold // Default text style
            ),
      ),
    );
  }
}
