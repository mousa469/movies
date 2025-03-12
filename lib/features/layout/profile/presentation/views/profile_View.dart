import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';


class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

	@override
	Widget build(BuildContext context) {
		return Column(
      children: [
        Center(
          child: Text(
            "profile item ",
            style: AppStyles.textStyle20SemiBold
                .copyWith(color: AppColors.whiteColor),
          ),
        )
      ],
    );
	}
}
