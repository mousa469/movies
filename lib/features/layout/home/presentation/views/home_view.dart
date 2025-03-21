import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/services/get_it_services.dart';
import 'package:movies/features/layout/home/domain/usecases/add_movie_to_history_use_case.dart';
import 'package:movies/features/layout/home/domain/usecases/fetch_available_movies_use_case.dart';
import 'package:movies/features/layout/home/domain/usecases/fetch_watch_now_movies_use_case.dart';
import 'package:movies/features/layout/home/presentation/bloc/add_movie_to_history_cubit/add_movie_to_history_cubit.dart';
import 'package:movies/features/layout/home/presentation/bloc/available_movies_cubit/available_movies_cubit.dart';
import 'package:movies/features/layout/home/presentation/bloc/watch_now_cubit/watch_now_cubit.dart';
import 'package:movies/features/layout/home/presentation/widgets/available_movies_bloc_consumer.dart';
import 'package:movies/features/layout/home/presentation/widgets/watch_now_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AvailableMoviesCubit(
              fetchAvailableMoviesUseCase:
                  getIt<FetchAvailableMoviesUseCase>()),
        ),
        BlocProvider(
          create: (context) => WatchNowCubit(
              watchNowMoviesUseCase: getIt<FetchWatchNowMoviesUseCase>()),
        ),
        BlocProvider(
          create: (context) => AddMovieToHistoryCubit(
              addMovieToHistoryUseCase: getIt<AddMovieToHistoryUseCase>()),
        )
      ],
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AvailableMoviesBlocConsumer(),
            WatchNowSection(),
          ],
        ),
      ),
    );
  }
}
