import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/extensions/padding_extension.dart';
import 'package:movies/core/extensions/space_extension.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/features/layout/home/domain/entities/cast.dart';

class CastCard extends StatelessWidget {
  const CastCard({super.key, required this.cast});

  final Cast cast;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryBlackColor,
          borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              width: 60,
              height: 60,
              imageUrl:
                  cast.characterImg,
              placeholder: (context, url) =>
                  Lottie.asset(Assets.animationsLoadingAnimation),
              errorWidget: (context, url, error) =>
                  Lottie.asset(Assets.animationsError),
            ),
          ),
          8.horizontalSpace(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name : ${cast.name} ",
                  style: AppStyles.textStyle20Regular,
                ),
                4.verticalSpace(),
                Text(
                  "Character : ${cast.characterName}",
                  style: AppStyles.textStyle20Regular,
                ),
              ],
            ),
          )
        ],
      ),
    ).symmetricPadding(horizontalValue: 8, verticalValue: 8);
  }
}
