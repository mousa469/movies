import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/extensions/media_query_extension.dart';
import 'package:movies/core/widgets/error_widget.dart';
import 'package:movies/features/layout/browse/presentation/bloc/browse_movies_by_category/browse_movies_by_category_cubit.dart';
import 'package:movies/features/layout/home/presentation/widgets/movies_item.dart';

class MoviesCategoryGridViewBuilder extends StatelessWidget {
  const MoviesCategoryGridViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowseMoviesByCategoryCubit,
        BrowseMoviesByCategoryState>(
      builder: (context, state) {
        if (state is BrowseMoviesByCategoryFailure) {
          return SliverToBoxAdapter(
            child: ErrorMessage(errMessage: state.errMessage),
          );
        } else if (state is BrowseMoviesByCategorySuccess) {
          if (state.movies.isEmpty) {
            return SliverToBoxAdapter(
              child: Center(child: Text("No Movies Available")),
            );
          }
          return SliverPadding(
            padding: const EdgeInsets.only(right: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final movie = state.movies[index];
                  return MoviesItem(
                    entity: movie,
                    height: context.screenHeight(.3),
                    width: context.screenWidth(.5),
                  );
                },
                childCount: state.movies.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          );
        } else {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: context.screenHeight(.5),
              child: Center(
                child: Lottie.asset(Assets.animationsLoadingAnimation),
              ),
            ),
          );
        }
      },
    );
  }
}
