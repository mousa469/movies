import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/extensions/routing_extension.dart';
import 'package:movies/core/widgets/movie_details_view.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/presentation/bloc/add_movie_to_history_cubit/add_movie_to_history_cubit.dart';
import 'package:movies/features/layout/home/presentation/widgets/available_movies_rating_item.dart';

class MoviesItem extends StatefulWidget {
  const MoviesItem(
      {super.key,
      required this.entity,
      required this.height,
      required this.width});

  final MovieEntity entity;
  final double height;
  final double width;

  @override
  State<MoviesItem> createState() => _MoviesItemState();
}

class _MoviesItemState extends State<MoviesItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(MovieDetailsView.id, arguments: widget.entity);
        context
            .read<AddMovieToHistoryCubit>()
            .addMovieToHistory(movie: widget.entity);
      },
      child: Stack(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            height: widget.height,
            width: widget.width,
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: widget.entity.poster,
              placeholder: (context, url) =>
                  Lottie.asset(Assets.animationsLoadingAnimation),
              errorWidget: (context, url, error) =>
                  Lottie.asset(Assets.animationsError),
            ),
          ),
          AvailableMoviesRatingItem(
            rate: widget.entity.rating,
          )
        ],
      ),
    );
  }
}
