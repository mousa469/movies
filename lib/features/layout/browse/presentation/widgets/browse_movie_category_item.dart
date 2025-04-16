import 'package:flutter/material.dart';
import 'package:movies/core/extensions/padding_extension.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';

class BrowseMovieCategoryItem extends StatelessWidget {
  const BrowseMovieCategoryItem(
      {super.key, required this.name, required this.isSelected});
  final String name;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.kPrimaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kPrimaryColor),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Text(
          name,
          style: AppStyles.textStyle20Bold.copyWith(
              color: isSelected
                  ? AppColors.secondaryBlackColor
                  : AppColors.kPrimaryColor),
        ),
      ),
    ).customePadding(right: 8);
  }
}
