import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/assets/app_assets.dart';

class AvailableMoviesBackgroundImg extends StatelessWidget {
  const AvailableMoviesBackgroundImg({super.key, required this.backImg});
  final String backImg;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.fill,
      width: double.infinity,
      imageUrl: backImg,
      placeholder: (context, url) =>
          Lottie.asset(Assets.animationsLoadingAnimation),
      errorWidget: (context, url, error) =>
          Lottie.asset(Assets.animationsError),
    );
  }
}
