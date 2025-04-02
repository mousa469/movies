import 'package:flutter/material.dart';
import 'package:movies/core/extensions/space_extension.dart';
import 'package:movies/core/theme/app_styles.dart';

class MovieSummary extends StatelessWidget {
  const MovieSummary({super.key, required this.discription});
  final String discription;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Summary",
              style: AppStyles.textStyle24Bold,
            ),
            16.verticalSpace(),
            Text(
              discription,
              style: AppStyles.textStyle16Regular,
            )
          ],
        ),
      ),
    );
  }
}
