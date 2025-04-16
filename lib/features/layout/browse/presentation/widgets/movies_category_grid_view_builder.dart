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
          return Expanded(child: ErrorMessage(errMessage: state.errMessage));
        } else if (state is BrowseMoviesByCategorySuccess) {
          return state.movies.isEmpty
              ? Center(child: Text("No Movies Available"))
              : Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.only(right: 16),
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
                          width: context.screenWidth(.5));
                    },
                  ),
                );
        } else {
          return Expanded(
              child: Lottie.asset(Assets.animationsLoadingAnimation));
        }
      },
    );
  }
}
