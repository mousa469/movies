import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/extensions/media_query_extension.dart';
import 'package:movies/features/layout/home/presentation/bloc/fetch_similar_movies/fetch_similar_movies_cubit.dart';
import 'package:movies/features/layout/home/presentation/widgets/movies_item.dart';

class SimilarMovieListView extends StatefulWidget {
  const SimilarMovieListView({super.key, required this.moviesID});

  final int moviesID;

  @override
  State<SimilarMovieListView> createState() => _SimilarMovieListViewState();
}

class _SimilarMovieListViewState extends State<SimilarMovieListView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FetchSimilarMoviesCubit>(context)
        .fetchSimilarMovies(id: widget.moviesID.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchSimilarMoviesCubit, FetchSimilarMoviesState>(
      builder: (context, state) {
        if (state is FetchSimilarMoviesSucces) {
          return SliverGrid.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.all(16),
                  child: MoviesItem(
                    entity: state.movies[index],
                    height: context.screenHeight(.2),
                    width: context.screenWidth(.5),
                  ));
            },
          );
        } else if (state is FetchSimilarMoviesFailure) {
          return SliverToBoxAdapter(
              child: Lottie.asset(Assets.animationsError));
        } else {
          return SliverToBoxAdapter(
              child: Lottie.asset(Assets.animationsLoadingAnimation));
        }
      },
    );
  }
}
