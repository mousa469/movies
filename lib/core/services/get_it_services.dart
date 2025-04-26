import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies/core/services/api_services.dart';
import 'package:movies/core/services/firbase_auth_services.dart';
import 'package:movies/core/services/firebase_firestore_services.dart';
import 'package:movies/core/services/local_storage/hive.dart';
import 'package:movies/core/services/network_checker.dart';
import 'package:movies/features/authentication/data/data_source/auth_local_data_source.dart';
import 'package:movies/features/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:movies/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:movies/features/authentication/domain/use_cases/create_new_user_use_case.dart';
import 'package:movies/features/authentication/domain/use_cases/sign_in_User_use_case.dart';
import 'package:movies/features/authentication/domain/use_cases/sign_in_with_facebook_use_case.dart';
import 'package:movies/features/authentication/domain/use_cases/sign_in_with_google_use_case.dart';
import 'package:movies/features/layout/browse/data/datasources/browse_movie_by_category_local_data_source.dart';
import 'package:movies/features/layout/browse/data/datasources/browse_movie_by_category_remote_data_source.dart';
import 'package:movies/features/layout/browse/data/repositories/browse_repo_impl.dart';
import 'package:movies/features/layout/browse/domain/usecases/browse_item_by_category_use_case.dart';
import 'package:movies/features/layout/home/data/datasources/home_local_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/home_remote_data_source.dart';
import 'package:movies/features/layout/home/data/repositories/home_repo_impl.dart';
import 'package:movies/features/layout/home/domain/usecases/add_movie_to_history_use_case.dart';
import 'package:movies/features/layout/home/domain/usecases/add_movie_to_wish_list_use_case.dart';
import 'package:movies/features/layout/home/domain/usecases/fetch_available_movies_use_case.dart';
import 'package:movies/features/layout/home/domain/usecases/fetch_movie_details_use_case.dart';
import 'package:movies/features/layout/home/domain/usecases/fetch_similar_movies_use_case.dart';
import 'package:movies/features/layout/home/domain/usecases/fetch_watch_now_movies_use_case.dart';
import 'package:movies/features/layout/profile/data/datasources/profile_local_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/profile_remote_data_source.dart';
import 'package:movies/features/layout/profile/data/repositories/profile_repo_impl.dart';
import 'package:movies/features/layout/profile/domain/usecases/fetch_list_of_movies_in_history_use_case.dart';
import 'package:movies/features/layout/profile/domain/usecases/fetch_list_of_movies_in_watch_list_use_case.dart';
import 'package:movies/features/layout/profile/domain/usecases/fetch_number_of_movies_in_history.dart';
import 'package:movies/features/layout/profile/domain/usecases/fetch_number_of_watch_list_movies_use_case.dart';
import 'package:movies/features/layout/profile/domain/usecases/fetch_user_data_use_case.dart';
import 'package:movies/features/layout/profile/domain/usecases/log_out_use_case.dart';
import 'package:movies/features/layout/profile/domain/usecases/update_user_data_use_case.dart';
import 'package:movies/features/layout/search/data/datasources/search_movie_local_data_source.dart';
import 'package:movies/features/layout/search/data/datasources/search_movie_remote_data_source.dart';
import 'package:movies/features/layout/search/data/repositories/search_repo_impl.dart';
import 'package:movies/features/layout/search/domain/usecases/search_movies_use_case.dart';

final getIt = GetIt.instance;

void setup() {

  getIt.registerSingleton<AuthRepositoryImpl>(
    AuthRepositoryImpl(
      authRemoteDataSource: AuthRemoteDataSourceImpl(
          localStorage: HiveStorage(),
          firebaseAuthServices:
              FirebaseAuthServices(firebaseAuth: FirebaseAuth.instance),
          firebaseFirestore: FirebaseFirestore.instance,
          databaseServices: FirebaseFirestoreService(
              firebaseFirestore: FirebaseFirestore.instance)),
      authLocalDataSource: AuthLocalDataSourceImpl(localStorage: HiveStorage()),
    ),
  );

  
  getIt.registerSingleton<CreateNewUserUseCase>(
    CreateNewUserUseCase(
      authRepository: getIt<AuthRepositoryImpl>(),
    ),
  );
  

  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
    connectivityService: ConnectivityService(),
    homeLocalDataSource: HomeLocalDataSourceImpl(localStorage: HiveStorage()),
    homeRemoteDataSource: HomeRemoteDataSourceImpl(
        localStorage: HiveStorage(),
        apiService: ApiService(Dio()),
        databaseServices: FirebaseFirestoreService(
          firebaseFirestore: FirebaseFirestore.instance,
        )),
  ));

  getIt.registerSingleton<ProfileRepoImpl>(
    ProfileRepoImpl(
    connectivityService: ConnectivityService(),
    profileLocalDataSource:
        ProfileLocalDataSourceImpl(localStorage: HiveStorage()),
    profileRemoteDataSource: ProfileRemoteDataSourceImpl(
        databaseServices: FirebaseFirestoreService(
            firebaseFirestore: FirebaseFirestore.instance),
        localStorage: HiveStorage(),
        firebaseAuth: FirebaseAuth.instance,
        googleSignIn: GoogleSignIn(),
        facebookAuth: FacebookAuth.instance),
  ));

  getIt.registerSingleton<SearchMoviesUseCase>(
    SearchMoviesUseCase(
      searchRepo: SearchRepoImpl(
        searchMovieLocalDataSource:
            SearchMovieLocalDataSourceImpl(localStorage: HiveStorage()),
        connectivityService: ConnectivityService(),
        searchMovieRemoteDataSource: SearchMovieRemoteDataSourceImpl(
          apiService: ApiService(Dio()),
        ),
      ),
    ),
  );
  getIt.registerSingleton<BrowseMovieByCategoryUseCase>(
    BrowseMovieByCategoryUseCase(
        repo: BrowseRepoImpl(
            connectivityService: ConnectivityService(),
            browseMovieByCategoryRemoteDataSource:
                BrowseMovieByCategoryRemoteDataSourceImpl(
                    apiService: ApiService(Dio())),
            browseMovieByCategoryLocalDataSource:
                BrowseMovieByCategoryLocalDataSourceImpl(
                    localStorage: HiveStorage()))),
  );

  getIt.registerSingleton(
    FetchAvailableMoviesUseCase(
      homeRepo: getIt<HomeRepoImpl>(),
    ),
  );

  getIt.registerSingleton(
    AddMovieToWishListUseCase(
      homeRepo: getIt<HomeRepoImpl>(),
    ),
  );
  getIt.registerSingleton(
    FetchNumberOfMoviesInHistoryUseCase(profileRepo: getIt<ProfileRepoImpl>()),
  );
  getIt.registerSingleton(
    LogOutUseCase(profileRepo: getIt<ProfileRepoImpl>()),
  );
  getIt.registerSingleton(
    UpdateUserDataUseCase(profileRepo: getIt<ProfileRepoImpl>()),
  );
  getIt.registerSingleton(
    FetchListOfMoviesInWatchListUseCase(profileRepo: getIt<ProfileRepoImpl>()),
  );

  getIt.registerSingleton(
    FetchListOfMoviesInHistoryUseCase(profileRepo: getIt<ProfileRepoImpl>()),
  );
  getIt.registerSingleton(
    FetchNumberOfWatchListMoviesUseCase(profileRepo: getIt<ProfileRepoImpl>()),
  );
  getIt.registerSingleton(
    FetchUserDataUseCase(profileRepo: getIt<ProfileRepoImpl>()),
  );
  getIt.registerSingleton(
    FetchMovieDetailsUseCase(
      homeRepo: getIt<HomeRepoImpl>(),
    ),
  );
  getIt.registerSingleton(
    AddMovieToHistoryUseCase(
      homeRepo: getIt<HomeRepoImpl>(),
    ),
  );
  getIt.registerSingleton(
    FetchWatchNowMoviesUseCase(
      homeRepo: getIt<HomeRepoImpl>(),
    ),
  );
  getIt.registerSingleton(
    FetchSimilarMoviesUseCase(
      homeRepo: getIt<HomeRepoImpl>(),
    ),
  );

  getIt.registerSingleton(
    SignInUserUseCase(
      authRepository: getIt<AuthRepositoryImpl>(),
    ),
  );

  getIt.registerSingleton(
    SignInWithGoogleUseCase(
      authRepository: getIt<AuthRepositoryImpl>(),
    ),
  );
  getIt.registerSingleton(
    SignInWithFacebookUseCase(
      authRepository: getIt<AuthRepositoryImpl>(),
    ),
  );
}
