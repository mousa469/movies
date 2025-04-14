import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/services/get_it_services.dart';
import 'package:movies/features/layout/profile/domain/usecases/fetch_list_of_movies_in_history_use_case.dart';
import 'package:movies/features/layout/profile/domain/usecases/fetch_list_of_movies_in_watch_list_use_case.dart';
import 'package:movies/features/layout/profile/domain/usecases/fetch_number_of_movies_in_history.dart';
import 'package:movies/features/layout/profile/domain/usecases/fetch_number_of_watch_list_movies_use_case.dart';
import 'package:movies/features/layout/profile/domain/usecases/log_out_use_case.dart';
import 'package:movies/features/layout/profile/presentation/bloc/fetch_list_of_movies/fetch_list_of_movies_cubit.dart';
import 'package:movies/features/layout/profile/presentation/bloc/fetch_number_movies_in_watch_list/fetch_number_movies_in_watch_list_cubit.dart';
import 'package:movies/features/layout/profile/presentation/bloc/log_out_cubit/log_out_cubit.dart';
import 'package:movies/features/layout/profile/presentation/bloc/number_of_history_movies/number_of_history_movies_cubit.dart';
import 'package:movies/features/layout/profile/presentation/widgets/profile_view_footer_list.dart';
import 'package:movies/features/layout/profile/presentation/widgets/profile_view_header.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static const String id = "profile";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NumberOfHistoryMoviesCubit(
              fetchNumberOfMoviesInHistoryUseCase:
                  getIt<FetchNumberOfMoviesInHistoryUseCase>()),
        ),
        BlocProvider(
          create: (context) => FetchNumberMoviesInWatchListCubit(
              fetchNumberOfWatchListMoviesUseCase:
                  getIt<FetchNumberOfWatchListMoviesUseCase>()),
        ),
        BlocProvider(
          create: (context) => FetchListOfMoviesyCubit(
            fetchListOfMoviesInHistoryUseCase:
                getIt<FetchListOfMoviesInHistoryUseCase>(),
            fetchListOfMoviesInWatchListUseCase:
                getIt<FetchListOfMoviesInWatchListUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => LogOutCubit(
            logOutUseCase: getIt<LogOutUseCase>(),
          ),
        ),
      ],
      child: Column(
        children: [
          ProfileViewHeader(),
          ProfileViewFooterList(),
        ],
      ),
    );
  }
}
