import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/extensions/media_query_extension.dart';
import 'package:movies/features/layout/home/presentation/widgets/movies_item.dart';
import 'package:movies/features/layout/search/presentation/bloc/search_movie/search_movie_cubit.dart';

class SearchedMoviesItemGridView extends StatefulWidget {
  const SearchedMoviesItemGridView({super.key});

  @override
  State<SearchedMoviesItemGridView> createState() =>
      _SearchedMoviesItemGridViewState();
}

class _SearchedMoviesItemGridViewState
    extends State<SearchedMoviesItemGridView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchMovieCubit, SearchMovieState>(
      builder: (context, state) {
        if (state is SearchMovieSuccess) {
          return state.movies.isEmpty
              ? Center(child: Image.asset(Assets.emotyListOfMovies))
              : Expanded(
                  child: GridView.builder(
                    itemCount: state.movies.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return MoviesItem(
                        entity: state.movies[index],
                        height: context.screenHeight(.3),
                        width: context.screenWidth(.5),
                      );
                    },
                  ),
                );
        } else if (state is SearchMovieFailure) {
          return Center(child: Text(state.message));
        } else if (state is SearchMovieLoading) {
          return Expanded(
              child: Lottie.asset(Assets.animationsLoadingAnimation));
        } else {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.emotyListOfMovies,
                  scale: 5,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
