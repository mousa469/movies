import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/core/services/api_services.dart';
import 'package:movies/core/services/database_services.dart';
import 'package:movies/core/services/firbase_auth_services.dart';
import 'package:movies/core/services/local_storage/hive.dart';
import 'package:movies/core/services/network_checker.dart';
import 'package:movies/features/authentication/data/data_source/auth_local_data_source.dart';
import 'package:movies/features/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:movies/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:movies/features/authentication/domain/use_cases/create_new_user_use_case.dart';
import 'package:movies/features/authentication/domain/use_cases/sign_in_User_use_case.dart';
import 'package:movies/features/authentication/domain/use_cases/sign_in_with_facebook_use_case.dart';
import 'package:movies/features/authentication/domain/use_cases/sign_in_with_google_use_case.dart';
import 'package:movies/features/layout/home/data/datasources/add_movie_to_history_local_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/add_movie_to_history_remote_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/add_movie_to_wish_list_local_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/add_movie_to_wish_list_remote_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/availabe_movies_remote_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/available_movies_local_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/fetch_similar_movies_remote_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/movie_details_remote_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/watch_now_movies_local_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/watch_now_movies_remote_data_source.dart';
import 'package:movies/features/layout/home/data/repositories/home_repo_impl.dart';
import 'package:movies/features/layout/home/domain/usecases/add_movie_to_history_use_case.dart';
import 'package:movies/features/layout/home/domain/usecases/add_movie_to_wish_list_use_case.dart';
import 'package:movies/features/layout/home/domain/usecases/fetch_available_movies_use_case.dart';
import 'package:movies/features/layout/home/domain/usecases/fetch_movie_details_use_case.dart';
import 'package:movies/features/layout/home/domain/usecases/fetch_similar_movies_use_case.dart';
import 'package:movies/features/layout/home/domain/usecases/fetch_watch_now_movies_use_case.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<CreateNewUserUseCase>(CreateNewUserUseCase(
      authRepository: AuthRepositoryImpl(
          authRemoteDataSource: AuthRemoteDataSourceImpl(
              localStorage: HiveStorage(),
              databaseServices: FirebaseFirestoreService(
                  firebaseFirestore: FirebaseFirestore.instance),
              firebaseAuthServices:
                  FirebaseAuthServices(firebaseAuth: FirebaseAuth.instance),
              firebaseFirestore: FirebaseFirestore.instance),
          authLocalDataSource: AuthLocalDataSourceImpl(
            localStorage: HiveStorage(),
          ))));

  getIt.registerSingleton(
    FetchAvailableMoviesUseCase(
      homeRepo: HomeRepoImpl(
        connectivityService: ConnectivityService(),
        fetchSimilarMoviesRemoteDataSource:
            FetchSimilarMoviesRemoteDataSourceImpl(
                apiService: ApiService(Dio())),
        movieDetailsRemoteDataSource: FetchMovieDetailsRemoteDataSourceImpl(
            apiService: ApiService(Dio())),
        addMovieToHistoryLocalDataSource: AddMovieToHistoryLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
        addMovieToHistoryRemoteDataSource:
            AddMovieToHistoryRemoteDataSourceImpl(
                localStorage: HiveStorage(),
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance)),
        addMovieToWishListRemoteDataSource:
            AddMovieToWishListRemoteDataSourceimpl(
                localStorage: HiveStorage(),
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance)),
        addMovieToWishListLocalDataSource:
            AddMovieToWishListLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
        watchNowMoviesLocalDataSource: WatchNowMoviesLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
        wathchNowMoviesRemoteDataSource:
            WathchNowMoviesRemoteDataSourceimpl(apiService: ApiService(Dio())),
        availabeMoviesRemoteDataSource: AvailabeMoviesRemoteDataSourceImp(
          apiService: ApiService(Dio()),
        ),
        availableMoviesLocalDataSource: AvailableMoviesLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
      ),
    ),
  );

  getIt.registerSingleton(
    AddMovieToWishListUseCase(
      homeRepo: HomeRepoImpl(
        connectivityService: ConnectivityService(),
        fetchSimilarMoviesRemoteDataSource:
            FetchSimilarMoviesRemoteDataSourceImpl(
                apiService: ApiService(Dio())),
        movieDetailsRemoteDataSource: FetchMovieDetailsRemoteDataSourceImpl(
            apiService: ApiService(Dio())),
        addMovieToHistoryLocalDataSource: AddMovieToHistoryLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
        addMovieToHistoryRemoteDataSource:
            AddMovieToHistoryRemoteDataSourceImpl(
                localStorage: HiveStorage(),
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance)),
        addMovieToWishListRemoteDataSource:
            AddMovieToWishListRemoteDataSourceimpl(
                localStorage: HiveStorage(),
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance)),
        addMovieToWishListLocalDataSource:
            AddMovieToWishListLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
        watchNowMoviesLocalDataSource: WatchNowMoviesLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
        wathchNowMoviesRemoteDataSource:
            WathchNowMoviesRemoteDataSourceimpl(apiService: ApiService(Dio())),
        availabeMoviesRemoteDataSource: AvailabeMoviesRemoteDataSourceImp(
          apiService: ApiService(Dio()),
        ),
        availableMoviesLocalDataSource: AvailableMoviesLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
      ),
    ),
  );
  getIt.registerSingleton(
    FetchMovieDetailsUseCase(
      homeRepo: HomeRepoImpl(
        connectivityService: ConnectivityService(),
        fetchSimilarMoviesRemoteDataSource:
            FetchSimilarMoviesRemoteDataSourceImpl(
                apiService: ApiService(Dio())),
        movieDetailsRemoteDataSource: FetchMovieDetailsRemoteDataSourceImpl(
            apiService: ApiService(Dio())),
        addMovieToHistoryLocalDataSource: AddMovieToHistoryLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
        addMovieToHistoryRemoteDataSource:
            AddMovieToHistoryRemoteDataSourceImpl(
                localStorage: HiveStorage(),
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance)),
        addMovieToWishListRemoteDataSource:
            AddMovieToWishListRemoteDataSourceimpl(
                localStorage: HiveStorage(),
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance)),
        addMovieToWishListLocalDataSource:
            AddMovieToWishListLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
        watchNowMoviesLocalDataSource: WatchNowMoviesLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
        wathchNowMoviesRemoteDataSource:
            WathchNowMoviesRemoteDataSourceimpl(apiService: ApiService(Dio())),
        availabeMoviesRemoteDataSource: AvailabeMoviesRemoteDataSourceImp(
          apiService: ApiService(Dio()),
        ),
        availableMoviesLocalDataSource: AvailableMoviesLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
      ),
    ),
  );
  getIt.registerSingleton(
    AddMovieToHistoryUseCase(
      homeRepo: HomeRepoImpl(
        connectivityService: ConnectivityService(),
        fetchSimilarMoviesRemoteDataSource:
            FetchSimilarMoviesRemoteDataSourceImpl(
                apiService: ApiService(Dio())),
        movieDetailsRemoteDataSource: FetchMovieDetailsRemoteDataSourceImpl(
            apiService: ApiService(Dio())),
        addMovieToHistoryLocalDataSource: AddMovieToHistoryLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
        addMovieToHistoryRemoteDataSource:
            AddMovieToHistoryRemoteDataSourceImpl(
                localStorage: HiveStorage(),
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance)),
        addMovieToWishListRemoteDataSource:
            AddMovieToWishListRemoteDataSourceimpl(
                localStorage: HiveStorage(),
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance)),
        addMovieToWishListLocalDataSource:
            AddMovieToWishListLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
        watchNowMoviesLocalDataSource: WatchNowMoviesLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
        wathchNowMoviesRemoteDataSource:
            WathchNowMoviesRemoteDataSourceimpl(apiService: ApiService(Dio())),
        availabeMoviesRemoteDataSource: AvailabeMoviesRemoteDataSourceImp(
          apiService: ApiService(Dio()),
        ),
        availableMoviesLocalDataSource: AvailableMoviesLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
      ),
    ),
  );
  getIt.registerSingleton(
    FetchWatchNowMoviesUseCase(
      homeRepo: HomeRepoImpl(
        connectivityService: ConnectivityService(),
        fetchSimilarMoviesRemoteDataSource:
            FetchSimilarMoviesRemoteDataSourceImpl(
                apiService: ApiService(Dio())),
        movieDetailsRemoteDataSource: FetchMovieDetailsRemoteDataSourceImpl(
            apiService: ApiService(Dio())),
        addMovieToHistoryLocalDataSource: AddMovieToHistoryLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
        addMovieToHistoryRemoteDataSource:
            AddMovieToHistoryRemoteDataSourceImpl(
                localStorage: HiveStorage(),
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance)),
        addMovieToWishListRemoteDataSource:
            AddMovieToWishListRemoteDataSourceimpl(
                localStorage: HiveStorage(),
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance)),
        addMovieToWishListLocalDataSource:
            AddMovieToWishListLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
        watchNowMoviesLocalDataSource: WatchNowMoviesLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
        wathchNowMoviesRemoteDataSource:
            WathchNowMoviesRemoteDataSourceimpl(apiService: ApiService(Dio())),
        availabeMoviesRemoteDataSource: AvailabeMoviesRemoteDataSourceImp(
          apiService: ApiService(Dio()),
        ),
        availableMoviesLocalDataSource: AvailableMoviesLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
      ),
    ),
  );
  getIt.registerSingleton(
    FetchSimilarMoviesUseCase(
      homeRepo: HomeRepoImpl(
        connectivityService: ConnectivityService(),
        fetchSimilarMoviesRemoteDataSource:
            FetchSimilarMoviesRemoteDataSourceImpl(
                apiService: ApiService(Dio())),
        movieDetailsRemoteDataSource: FetchMovieDetailsRemoteDataSourceImpl(
            apiService: ApiService(Dio())),
        addMovieToHistoryLocalDataSource: AddMovieToHistoryLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
        addMovieToHistoryRemoteDataSource:
            AddMovieToHistoryRemoteDataSourceImpl(
                localStorage: HiveStorage(),
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance)),
        addMovieToWishListRemoteDataSource:
            AddMovieToWishListRemoteDataSourceimpl(
                localStorage: HiveStorage(),
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance)),
        addMovieToWishListLocalDataSource:
            AddMovieToWishListLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
        watchNowMoviesLocalDataSource: WatchNowMoviesLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
        wathchNowMoviesRemoteDataSource:
            WathchNowMoviesRemoteDataSourceimpl(apiService: ApiService(Dio())),
        availabeMoviesRemoteDataSource: AvailabeMoviesRemoteDataSourceImp(
          apiService: ApiService(Dio()),
        ),
        availableMoviesLocalDataSource: AvailableMoviesLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
      ),
    ),
  );

  getIt.registerSingleton(
    SignInUserUseCase(
      authRepository: AuthRepositoryImpl(
        authRemoteDataSource: AuthRemoteDataSourceImpl(
            localStorage: HiveStorage(),
            databaseServices: FirebaseFirestoreService(
                firebaseFirestore: FirebaseFirestore.instance),
            firebaseAuthServices:
                FirebaseAuthServices(firebaseAuth: FirebaseAuth.instance),
            firebaseFirestore: FirebaseFirestore.instance),
        authLocalDataSource: AuthLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
      ),
    ),
  );

  getIt.registerSingleton(
    SignInWithGoogleUseCase(
      authRepository: AuthRepositoryImpl(
        authRemoteDataSource: AuthRemoteDataSourceImpl(
            localStorage: HiveStorage(),
            databaseServices: FirebaseFirestoreService(
                firebaseFirestore: FirebaseFirestore.instance),
            firebaseAuthServices:
                FirebaseAuthServices(firebaseAuth: FirebaseAuth.instance),
            firebaseFirestore: FirebaseFirestore.instance),
        authLocalDataSource: AuthLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
      ),
    ),
  );
  getIt.registerSingleton(
    SignInWithFacebookUseCase(
      authRepository: AuthRepositoryImpl(
        authRemoteDataSource: AuthRemoteDataSourceImpl(
            localStorage: HiveStorage(),
            databaseServices: FirebaseFirestoreService(
                firebaseFirestore: FirebaseFirestore.instance),
            firebaseAuthServices:
                FirebaseAuthServices(firebaseAuth: FirebaseAuth.instance),
            firebaseFirestore: FirebaseFirestore.instance),
        authLocalDataSource: AuthLocalDataSourceImpl(
          localStorage: HiveStorage(),
        ),
      ),
    ),
  );
}
