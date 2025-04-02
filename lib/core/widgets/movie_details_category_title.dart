import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_styles.dart';

class MovieDetailsCategoryTitle extends StatelessWidget {
  const MovieDetailsCategoryTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
        child: Text(
          title,
          style: AppStyles.textStyle24Bold,
        ),
      ),
    );
  }
}
