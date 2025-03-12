import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movies/core/extensions/media_query_extension.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/presentation/widgets/movies_item.dart';

class CarouselWidget extends StatelessWidget {
  final List<MovieEntity> movies;
  final double height;
  final bool autoPlay;
  final bool infiniteScroll;
  final CarouselSliderController? controller;
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;

  const CarouselWidget({
    super.key,
    required this.movies,
    required this.onPageChanged,
    required this.autoPlay,
    required this.height,
    this.infiniteScroll = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: controller,
      itemCount: movies.length,
      itemBuilder: (context, index, realIndex) {
        return MoviesItem(
          height: context.screenHeight(0.3766),
          width: context.screenWidth(0.5372),
          entity: movies[index],
        );
      },
      options: CarouselOptions(
        onPageChanged: onPageChanged,
        height: height,
        viewportFraction: 0.5,
        autoPlay: autoPlay,
        enableInfiniteScroll: infiniteScroll,
        enlargeCenterPage: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
      ),
    );
  }
}
