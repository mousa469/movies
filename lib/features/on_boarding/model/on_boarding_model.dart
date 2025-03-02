import 'package:flutter/material.dart';
import 'package:movies/core/assets/app_assets.dart';

class OnBoardingModel {
  final String backgroungImage;
  final String title;
  final List<Color>? colors;
  final String? subTitle;

  OnBoardingModel(
      {required this.title,
      this.subTitle,
      required this.backgroungImage,
      this.colors});
  static List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
      colors: [
        Color(0xFF1E1E1E).withValues(alpha: 0),
        Color(0xFF121312).withValues(alpha: .5),
        Color(0xFF121312).withValues(alpha: .9),
        Color(0xFF121312).withValues(alpha: 1),
      ],
      backgroungImage: Assets.imagesOnBoardingBackImg1,
      subTitle:
          "Get access to a huge library of movies to suit all tastes. You will surely like it.",
      title: "Find Your Next \n Favorite Movie Here",
    ),
    OnBoardingModel(
      colors: [
        Color(0xFF084250).withValues(alpha: 0),
        Color(0xFF084250).withValues(alpha: 1),
      ],
      backgroungImage: Assets.imagesOnBoardingBackImg2,
      subTitle:
          "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
      title: "Discover Movies",
    ),
    OnBoardingModel(
      colors: [
        Color(0xFF85210E).withValues(alpha: 0),
        Color(0xFF85210E).withValues(alpha: 1),
      ],
      backgroungImage: Assets.imagesOnBoardingBackImg3,
      subTitle:
          "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
      title: "Explore All Genres",
    ),
    OnBoardingModel(
      colors: [
        Color(0xFF4C2471).withValues(alpha: 0),
        Color(0xFF4C2471).withValues(alpha: 1),
      ],
      backgroungImage: Assets.imagesOnBoardingBackImg4,
      subTitle:
          "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
      title: "Create Watchlists",
    ),
    OnBoardingModel(
      colors: [
        Color(0xFF601321).withValues(alpha: 0),
        Color(0xFF601321).withValues(alpha: 1),
      ],
      backgroungImage: Assets.imagesOnBoardingBackImg5,
      subTitle:
          "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
      title: "Rate, Review, and Learn",
    ),
    OnBoardingModel(
      colors: [
        Color(0xFF2A2C30).withValues(alpha: 0),
        Color(0xFF2A2C30).withValues(alpha: 1),
       
      ],
      backgroungImage: Assets.imagesOnBoardingBackImg6,
      title: "Start Watching Now",
    ),
  ];
}
