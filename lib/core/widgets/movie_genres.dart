import 'package:flutter/material.dart';
import 'package:movies/core/extensions/padding_extension.dart';
import 'package:movies/core/extensions/space_extension.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';

class MovieGenres extends StatelessWidget {
  const MovieGenres({super.key, required this.genres});

  final List<String> genres;

  @override
  Widget build(BuildContext context) {
    return genres.isNotEmpty
        ? SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Genres",
                  style: AppStyles.textStyle24Bold,
                ),
                8.verticalSpace(),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(
                    genres.length,
                    (index) {
                      return Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.primaryBlackColor),
                        child: Text(genres[index]),
                      );
                    },
                  ),
                ),
              ],
            ).symmetricPadding(horizontalValue: 8, verticalValue: 16),
          )
        : SliverToBoxAdapter(
            child: Text("No genres available").horizontalPadding(value: 16),
          );
  }
}
