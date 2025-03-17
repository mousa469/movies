import 'package:flutter/material.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/extensions/padding_extension.dart';
import 'package:movies/features/layout/home/presentation/widgets/watch_now_list_view_builder.dart';

class WatchNowSection extends StatelessWidget {
  const WatchNowSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(Assets.imagesWatchNowP)
            .symmetricPadding(horizontalValue: 24, verticalValue: 10),
        WatchNowListViewBuilder()
      ],
    );
  }
}
