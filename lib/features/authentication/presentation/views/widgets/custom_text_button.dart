
import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.text, this.onPress, });

  final String text;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return    TextButton(
      onPressed: onPress ,
      child: Text(
        text,
        style: AppStyles.textStyle16Regular.copyWith(
            decoration: TextDecoration.underline,
            decorationColor: AppColors.kPrimaryColor,
            color: AppColors.kPrimaryColor),
      ),
    );
  }
}
