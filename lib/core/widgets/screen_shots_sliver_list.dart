import 'package:flutter/material.dart';
import 'package:movies/core/widgets/movie_screen_shot.dart';

class ScreenShotsSliverList extends StatelessWidget {
  const ScreenShotsSliverList({
    super.key,
    required this.screenShots,
  });
  final List<String> screenShots;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: screenShots.length,
      itemBuilder: (context, index) {
        return MovieScreenShot(img: screenShots[index]);
      },
    );
  }
}
