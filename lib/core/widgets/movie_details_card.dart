import 'package:flutter/material.dart';
import 'package:movies/core/extensions/space_extension.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/widgets/movie_details_image.dart';
import 'package:movies/core/widgets/movie_details_rating.dart';
import 'package:movies/core/widgets/movie_details_section.dart';

class MovieDetailsCard extends StatelessWidget {
  const MovieDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      padding: EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MovieDetailsImage(),
              12.horizontalSpace(),
              MovieDetailsSection()
            ],
          ),
          10.verticalSpace(),
          MovieDetailsRating(),
        ],
      ),
    );
  }
}
