import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            "search item ",
            style: AppStyles.textStyle20SemiBold
                .copyWith(color: AppColors.whiteColor),
          ),
        )
      ],
    );
  }
}
