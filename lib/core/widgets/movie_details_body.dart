import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/widgets/movie_cast.dart';
import 'package:movies/core/widgets/movie_details_app_bar.dart';
import 'package:movies/core/widgets/movie_details_category_title.dart';
import 'package:movies/core/widgets/movie_genres.dart';
import 'package:movies/core/widgets/movie_summary.dart';
import 'package:movies/core/widgets/screen_shots_sliver_list.dart';
import 'package:movies/core/widgets/similar_movie_list_view.dart';
import 'package:movies/features/layout/home/presentation/bloc/fetch_movie_details/fetch_movie_details_cubit.dart';

class MovieDetailsBody extends StatefulWidget {
  const MovieDetailsBody({super.key, required this.movieID});
  final int movieID;

  @override
  State<MovieDetailsBody> createState() => _MovieDetailsBodyState();
}

class _MovieDetailsBodyState extends State<MovieDetailsBody> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<FetchMovieDetailsCubit>(context)
        .fetchMovieDetails(movieID: widget.movieID.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchMovieDetailsCubit, FetchMovieDetailsState>(
      builder: (context, state) {
        print("🛠 Rebuilding UI with state: $state"); // Debugging Log

        if (state is FetchMovieDetailsSuccess) {
          log("fetch movie  success is executed ");
          return CustomScrollView(
            slivers: [
              MovieDetailsAppBar(
                id: state.movie.id.toInt(),
                youtubeCode: state.movie.youtubeTrailerCode,
                movieURL: state.movie.url,
                movieBackground: state.movie.backgroundImg ?? "",
                movieLikes: state.movie.likeCount ?? 0,
                movieRating: state.movie.rating ?? 0,
                movieRuntime: state.movie.runTime ?? 0,
                movieTitle:
                    state.movie.title ?? "Unknown Title", // Handle null values
                movieYear: state.movie.year ?? 0,
              ),
              MovieDetailsCategoryTitle(
                title: "Screen shots",
              ),
              ScreenShotsSliverList(
                screenShots: state.movie.screenShots,
              ),
              MovieDetailsCategoryTitle(
                title: "Similar",
              ),
              SimilarMovieListView(
                moviesID: state.movie.id.toInt(),
              ),
              MovieSummary(
                discription: state.movie.descriptionIntro.isNotEmpty
                    ? state.movie.descriptionIntro
                    : "No description available", // Handle missing description
              ),
              MovieDetailsCategoryTitle(
                title: "Cast",
              ),
              MovieCast(
                cast: state.movie.cast ?? [], // Ensure non-null cast list
              ),
              MovieGenres(
                genres: state.movie.genres ?? [], // Ensure non-null genres list
              ),
            ],
          );
        } else if (state is FetchMovieDetailsFailure) {
          log("fetch movie  failure is executed ");

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red, size: 48),
                SizedBox(height: 10),
                Text(
                  state.errMessage,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else {
          log("fetch movie  loading is executed ");

          return Center(
            child: Lottie.asset(Assets.animationsLoadingAnimation),
          );
        }
      },
    );
  }
}
