
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/constants.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/helper%20functions/custom_snake_bar.dart';
import 'package:movies/core/widgets/error_widget.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/presentation/bloc/available_movies_cubit/available_movies_cubit.dart';
import 'package:movies/features/layout/home/presentation/widgets/available_movies_section.dart';

class AvailableMoviesBlocConsumer extends StatefulWidget {
  const AvailableMoviesBlocConsumer({super.key});

  @override
  State<AvailableMoviesBlocConsumer> createState() =>
      _AvailableMoviesBlocConsumerState();
}

class _AvailableMoviesBlocConsumerState
    extends State<AvailableMoviesBlocConsumer> {
  List<MovieEntity> moviesList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AvailableMoviesCubit>(context).fetchAvailabeMovies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvailableMoviesCubit, AvailableMoviesState>(
      listener: (context, state) {
        if (state is AvailableMoviesSuccess) {
          moviesList = state.movies;
          isLoading = false;
        }
        if (state is AvailableMoviesFailure) {
          showAwesomeSnackBar(
              context: context,
              title: opps,
              message: state.errMessage,
              contentType: ContentType.failure);
        }
      },
      builder: (context, state) {
        if (state is AvailableMoviesFailure) {
          return ErrorMessage(errMessage: state.errMessage);
        } else if (state is AvailableMoviesLoading) {
          return Lottie.asset(Assets.animationsLoadingAnimation);
        } else {
          return AvailableMoviesSection(movies: moviesList);
        }
      },
    );
  }
}
