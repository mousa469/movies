import 'package:flutter/material.dart';
import 'package:movies/core/extensions/space_extension.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';

class UserItemInformation extends StatelessWidget {
  const UserItemInformation(
      {super.key, required this.icon, required this.info});
  final IconData icon;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryBlackColor,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon),
            16.horizontalSpace(),
            Text(
              info,
              style: AppStyles.textStyle20Regular,
            )
          ],
        ),
      ),
    );
  }
}
