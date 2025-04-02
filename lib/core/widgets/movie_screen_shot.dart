import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/extensions/media_query_extension.dart';

class MovieScreenShot extends StatelessWidget {
  const MovieScreenShot({super.key, required this.img});

  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          // color: Colors.red,
          ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          height: context.screenHeight(.2),
          width: context.screenWidth(1),
          imageUrl: img,
          errorWidget: (context, url, error) =>
              Lottie.asset(Assets.animationsError),
          placeholder: (context, url) =>
              Lottie.asset(Assets.animationsLoadingAnimation),
        ),
      ),
    );
  }
}
