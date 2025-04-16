import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies/core/helper%20functions/custom_easy_loading.dart';
import 'package:movies/core/router/app_router.dart';
import 'package:movies/core/services/bloc_observer.dart';
import 'package:movies/core/services/get_it_services.dart';
import 'package:movies/core/services/local_storage/hive.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/layout/browse/presentation/views/browse_view.dart';
import 'package:movies/features/layout/home/domain/usecases/add_movie_to_history_use_case.dart';
import 'package:movies/features/layout/home/domain/usecases/add_movie_to_wish_list_use_case.dart';

import 'package:movies/features/layout/home/domain/usecases/fetch_movie_details_use_case.dart';
import 'package:movies/features/layout/home/domain/usecases/fetch_similar_movies_use_case.dart';
import 'package:movies/features/layout/home/presentation/bloc/add_movie_to_history_cubit/add_movie_to_history_cubit.dart';
import 'package:movies/features/layout/home/presentation/bloc/add_movie_to_wish_list_cubit/add_movie_to_wishlist_cubit.dart';
import 'package:movies/features/layout/home/presentation/bloc/fetch_movie_details/fetch_movie_details_cubit.dart';
import 'package:movies/features/layout/home/presentation/bloc/fetch_similar_movies/fetch_similar_movies_cubit.dart';
import 'package:movies/features/layout/presentation/views/layout_view.dart';
import 'package:movies/features/layout/profile/domain/usecases/fetch_user_data_use_case.dart';
import 'package:movies/features/layout/profile/domain/usecases/update_user_data_use_case.dart';
import 'package:movies/features/layout/profile/presentation/bloc/fetch_user_data/fetch_user_data_cubit.dart';
import 'package:movies/features/layout/profile/presentation/bloc/update_user_data/update_user_data_cubit.dart';
import 'package:movies/features/layout/search/presentation/views/search_view.dart';

import 'package:movies/firebase_options.dart';
import 'package:movies/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  CustomEasyLoading.configLoading();
  await HiveStorage().init();
  setup();

  Bloc.observer = SimpleBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => FetchMovieDetailsCubit(
                fetchMovieDetailsUseCase: getIt<FetchMovieDetailsUseCase>())),
        BlocProvider(
            create: (context) => FetchSimilarMoviesCubit(
                fetchSimilarMoviesUseCase: getIt<FetchSimilarMoviesUseCase>())),
        BlocProvider(
          create: (context) => AddMovieToHistoryCubit(
              addMovieToHistoryUseCase: getIt<AddMovieToHistoryUseCase>()),
        ),
        BlocProvider(
          create: (context) => AddMovieToWishlistCubit(
              addMovieToWishListUseCase: getIt<AddMovieToWishListUseCase>()),
        ),
        BlocProvider(
          create: (context) => FetchUserDataCubit(
              fetchUserDataUseCase: getIt<FetchUserDataUseCase>()),
        ),
        BlocProvider(
          create: (context) => UpdateUserDataCubit(
              updateUserDataUseCase: getIt<UpdateUserDataUseCase>()),
        ),
      ],
      child: MaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        initialRoute: LayoutView.id,
        onGenerateRoute: AppRouter.onGenerateRoute,
        locale: Locale("en"),
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.secondaryBlackColor,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple, brightness: Brightness.dark),
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
      ),
    );
  }
}
