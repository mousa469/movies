import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/extensions/media_query_extension.dart';
import 'package:movies/core/extensions/padding_extension.dart';
import 'package:movies/core/widgets/error_widget.dart';
import 'package:movies/features/layout/home/presentation/widgets/movies_item.dart';
import 'package:movies/features/layout/profile/presentation/bloc/fetch_list_of_movies/fetch_list_of_movies_cubit.dart';

class ProfileViewFooterList extends StatefulWidget {
  const ProfileViewFooterList({super.key});

  @override
  State<ProfileViewFooterList> createState() => _ProfileViewFooterListState();
}

class _ProfileViewFooterListState extends State<ProfileViewFooterList> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FetchListOfMoviesyCubit>(context)
        .fetchListOfMoviesInHistory();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchListOfMoviesyCubit, FetchListOfMoviesState>(
      builder: (context, state) {
        if (state is FetchListOfMoviesSuccess) {
          log("FetchListOfMoviesInHistorySuccess is triggered ");
          return state.movies.isEmpty
              ? Expanded(
                  child: Center(
                    child: Image.asset(
                      Assets.emotyListOfMovies,
                      scale: 5,
                    ),
                  ),
                )
              : Expanded(
                  child: GridView.builder(
                    itemCount: state.movies.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 10,
                      childAspectRatio: .7,
                    ),
                    itemBuilder: (context, index) {
                      return MoviesItem(
                          entity: state.movies[index],
                          height: context.screenHeight(.3),
                          width: context.screenWidth(.3));
                    },
                  ).horizontalPadding(value: 6),
                );
        } else if (state is FetchListOfMoviesFailure) {
          return ErrorMessage(errMessage: state.errMessage);
        } else {
          return Expanded(
              child: Center(
                  child: Lottie.asset(Assets.animationsLoadingAnimation,
                      width: context.screenWidth(.6))));
        }
      },
    );
  }
}
