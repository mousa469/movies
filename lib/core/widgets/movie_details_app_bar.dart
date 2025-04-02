import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/extensions/padding_extension.dart';
import 'package:movies/core/extensions/routing_extension.dart';
import 'package:movies/core/extensions/space_extension.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/core/widgets/custom_button.dart';
import 'package:movies/core/widgets/movie_info.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/presentation/widgets/add_movie_to_wish_list_bloc_Listener.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsAppBar extends StatelessWidget {
  const MovieDetailsAppBar(
      {super.key,
      required this.movieBackground,
      required this.movieTitle,
      required this.id,
      required this.movieYear,
      required this.movieLikes,
      required this.movieRuntime,
      required this.movieRating,
      required this.movieURL,
      required this.youtubeCode});

  final String movieBackground;
  final String movieTitle;
  final num movieYear;
  final int id;
  final num movieLikes;
  final num movieRuntime;
  final num movieRating;
  final String movieURL;
  final String youtubeCode;

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      sliver: SliverAppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.whiteColor,
              ),
            ),
            Spacer(),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.bookmark, color: AppColors.whiteColor))
          ],
        ),
        expandedHeight: 450,
        pinned: true,
        floating: false,
        flexibleSpace: FlexibleSpaceBar(
          background: Column(
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: movieBackground,
                      errorWidget: (context, url, error) =>
                          Lottie.asset(Assets.animationsLoadingAnimation),
                      placeholder: (context, url) =>
                          Lottie.asset(Assets.animationsLoadingAnimation),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF1E1E1E).withValues(alpha: 0.7),
                            Color(0xFF121312).withValues(alpha: .5),
                            Color(0xFF121312).withValues(alpha: .3),
                            Color(0xFF121312).withValues(alpha: .1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: AppColors.kPrimaryColor,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.whiteColor,
                          child: CircleAvatar(
                              backgroundColor: AppColors.kPrimaryColor,
                              radius: 20,
                              child: IconButton(
                                onPressed: () {
                                  launchTrailer(youtubeCode);
                                },
                                icon: Icon(
                                  Icons.play_arrow,
                                  color: AppColors.whiteColor,
                                ),
                              )),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            movieTitle,
                            textAlign: TextAlign.center,
                            style: AppStyles.textStyle24Bold,
                          ),
                        ),
                        6.verticalSpace(),
                        Text(
                          movieYear.toString(),
                          textAlign: TextAlign.center,
                          style: AppStyles.textStyle20Bold.copyWith(
                            color: Colors.white.withValues(alpha: .8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // 16.verticalSpace(),
              Column(
                children: [
                  CustomElevatedButton(
                    onPressed: launchMovieURL,
                    color: AppColors.redColor,
                    child: Text(
                      "Watch",
                      style: AppStyles.textStyle20Bold
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                  AddMovieToWishListBlocListener(
                    movie: MovieEntity(
                        mediumCoverImage: movieBackground,
                        id: id,
                        rating: movieRating),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MovieInfo(
                        icon: Icons.favorite,
                        text: movieLikes.toString(),
                      ),
                      MovieInfo(
                        icon: Icons.timelapse_rounded,
                        text: movieRuntime.toString(),
                      ),
                      MovieInfo(
                        icon: Icons.star,
                        text: movieRating.toString(),
                      ),
                    ],
                  )
                ],
              ).symmetricPadding(horizontalValue: 16, verticalValue: 16)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> launchMovieURL() async {
    final Uri url = Uri.parse(movieURL);

    if (!await launchUrl(url)) {
      throw Exception("Could not launch $url");
    }
  }

  Future<void> launchTrailer(String trailerCode) async {
    final Uri url = Uri.parse("https://www.youtube.com/watch?v=$trailerCode");

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }
}
