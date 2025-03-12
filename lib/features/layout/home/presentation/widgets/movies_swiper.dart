import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/extensions/media_query_extension.dart';
import 'package:movies/core/extensions/padding_extension.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/presentation/widgets/movies_item.dart';

class MoviesSwiper extends StatefulWidget {
  const MoviesSwiper({super.key, required this.movies, required this.onIndexChanged});
  final List<MovieEntity> movies;
  final void Function(int)? onIndexChanged;

  @override
  State<MoviesSwiper> createState() => _MoviesSwiperState();
}

class _MoviesSwiperState extends State<MoviesSwiper> {
  late String backImg;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(Assets.imagesAvailableNowBetter)
            .symmetricPadding(horizontalValue: 24, verticalValue: 16),
        SizedBox(
          height: context.screenHeight(0.4),
          child: Swiper(
            layout: SwiperLayout.DEFAULT,
            viewportFraction: .5,
            scale: 0.6,
            autoplay: false,
            onIndexChanged: widget.onIndexChanged,
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              return MoviesItem(
                entity: widget.movies[index],
                height: context.screenHeight(0.3766),
                width: context.screenWidth(0.5372),
              );
            },
          ),
        ),
      ],
    );
  }
}
