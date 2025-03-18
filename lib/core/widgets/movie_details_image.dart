import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/extensions/media_query_extension.dart';

class MovieDetailsImage extends StatelessWidget {
  const MovieDetailsImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        width: context.screenWidth(.4),
                        height: context.screenHeight(.4),
                        imageUrl:
                            "https://yts.mx/assets/images/movies/ferrell_takes_the_field_2015/medium-cover.jpg",
                        placeholder: (context, url) =>
                            Lottie.asset(Assets.animationsLoadingAnimation),
                        errorWidget: (context, url, error) =>
                            Lottie.asset(Assets.animationsLoadingAnimation),
                      ),
                    );
  }
}