import 'package:flutter/material.dart';
import 'package:movies/core/extensions/padding_extension.dart';
import 'package:movies/core/extensions/space_extension.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';

class MovieInfo extends StatelessWidget {
  const MovieInfo({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: AppColors.primaryBlackColor,
          borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        Icon(
          icon,
          color: AppColors.kPrimaryColor,
        ),
        6.horizontalSpace(),
        Text(
          text,
          style: AppStyles.textStyle24Bold,
        ),
      ]),
    ).verticalPadding(value: 8);
  }
}
