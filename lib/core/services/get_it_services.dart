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
import 'package:movies/features/layout/profile/data/datasources/fetch_list_of_movies_in_history.dart';
import 'package:movies/features/layout/profile/data/datasources/fetch_list_of_movies_in_history_local_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/fetch_list_of_movies_in_watch_list_local_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/fetch_list_of_movies_in_watch_list_remote_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/fetch_number_of_movies_in_history_remote_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/fetch_number_of_movies_in_watch_list_remote_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/fetch_user_data_local_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/fetch_user_data_remote_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/log_out_remote_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/number_of_movies_in_history_local_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/number_of_movies_of_watch_list.dart';
import 'package:movies/features/layout/profile/data/datasources/update_user_data_local_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/update_user_data_remote_data_source.dart';
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
  getIt.registerSingleton<CreateNewUserUseCase>(
    CreateNewUserUseCase(
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
    FetchNumberOfMoviesInHistoryUseCase(
        profileRepo: ProfileRepoImpl(
            logOutDataSource: LogOutRemoteDataSourceImpl(
              localStorage: HiveStorage(),
              firebaseAuth: FirebaseAuth.instance,
              googleSignIn: GoogleSignIn(),
              facebookAuth: FacebookAuth.instance,
            ),
            fetchListOfMoviesInWatchListLocalDataSource:
                FetchListOfMoviesInWatchListLocalDataSourceImpl(
                    localStorage: HiveStorage()),
            fetchListOfMoviesInWatchListRemoteDataSource:
                FetchListOfMoviesInWatchListRemoteDataSourceImpl(
              localStorage: HiveStorage(),
              databaseServices: FirebaseFirestoreService(
                  firebaseFirestore: FirebaseFirestore.instance),
            ),
            fetchListOfMoviesInHistoryRemoteDataSource:
                FetchListOfMoviesInHistoryRemoteDataSourceImpl(
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance),
                    localStorage: HiveStorage()),
            fetchListOfMoviesInHistoryLocalDataSource:
                FetchListOfMoviesInHistoryLocalDataSourceImpl(
              localStorage: HiveStorage(),
            ),
            updateUserDataRemoteDataSource: UpdateUserDataRemoteDataSourceImpl(
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance),
                localStorage: HiveStorage()),
            updateUserDataLocalDataSource:
                UpdateUserDataLocalDataSourceImpl(localStorage: HiveStorage()),
            userDataLocalDataSource:
                UserDataLocalDataSourceImpl(localStorage: HiveStorage()),
            fetchUserDataRemoteDataSource: FetchUserDataRemoteDataSourceImpl(
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance),
                localStorage: HiveStorage()),
            numberOfMoviesInWatchListLocalDataSource:
                NumberOfMoviesInWatchListLocalDataSourceImpl(
                    localStorage: HiveStorage()),
            fetchNumberOfMoviesInWatchListRemoteDataSource:
                FetchNumberOfMoviesInWatchListRemoteDataSourceImpl(
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance),
                    localStorage: HiveStorage()),
            connectivityService: ConnectivityService(),
            fetchNumberOfMoviesInHistoryRemoteDataSource:
                FetchNumberOfMoviesInHistoryRemoteDataSourceImpl(
                    localStorage: HiveStorage(),
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance)),
            numberOfMoviesInHistoryLocalDataSource:
                NumberOfMoviesInHistoryLocalDataSourceImpl(
                    localStorage: HiveStorage()))),
  );
  getIt.registerSingleton(
    LogOutUseCase(
        profileRepo: ProfileRepoImpl(
            logOutDataSource: LogOutRemoteDataSourceImpl(
              localStorage: HiveStorage(),
              firebaseAuth: FirebaseAuth.instance,
              googleSignIn: GoogleSignIn(),
              facebookAuth: FacebookAuth.instance,
            ),
            fetchListOfMoviesInWatchListLocalDataSource:
                FetchListOfMoviesInWatchListLocalDataSourceImpl(
                    localStorage: HiveStorage()),
            fetchListOfMoviesInWatchListRemoteDataSource:
                FetchListOfMoviesInWatchListRemoteDataSourceImpl(
              localStorage: HiveStorage(),
              databaseServices: FirebaseFirestoreService(
                  firebaseFirestore: FirebaseFirestore.instance),
            ),
            fetchListOfMoviesInHistoryRemoteDataSource:
                FetchListOfMoviesInHistoryRemoteDataSourceImpl(
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance),
                    localStorage: HiveStorage()),
            fetchListOfMoviesInHistoryLocalDataSource:
                FetchListOfMoviesInHistoryLocalDataSourceImpl(
              localStorage: HiveStorage(),
            ),
            updateUserDataRemoteDataSource: UpdateUserDataRemoteDataSourceImpl(
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance),
                localStorage: HiveStorage()),
            updateUserDataLocalDataSource:
                UpdateUserDataLocalDataSourceImpl(localStorage: HiveStorage()),
            userDataLocalDataSource:
                UserDataLocalDataSourceImpl(localStorage: HiveStorage()),
            fetchUserDataRemoteDataSource: FetchUserDataRemoteDataSourceImpl(
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance),
                localStorage: HiveStorage()),
            numberOfMoviesInWatchListLocalDataSource:
                NumberOfMoviesInWatchListLocalDataSourceImpl(
                    localStorage: HiveStorage()),
            fetchNumberOfMoviesInWatchListRemoteDataSource:
                FetchNumberOfMoviesInWatchListRemoteDataSourceImpl(
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance),
                    localStorage: HiveStorage()),
            connectivityService: ConnectivityService(),
            fetchNumberOfMoviesInHistoryRemoteDataSource:
                FetchNumberOfMoviesInHistoryRemoteDataSourceImpl(
                    localStorage: HiveStorage(),
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance)),
            numberOfMoviesInHistoryLocalDataSource:
                NumberOfMoviesInHistoryLocalDataSourceImpl(
                    localStorage: HiveStorage()))),
  );
  getIt.registerSingleton(
    UpdateUserDataUseCase(
        profileRepo: ProfileRepoImpl(
            logOutDataSource: LogOutRemoteDataSourceImpl(
              localStorage: HiveStorage(),
              firebaseAuth: FirebaseAuth.instance,
              googleSignIn: GoogleSignIn(),
              facebookAuth: FacebookAuth.instance,
            ),
            fetchListOfMoviesInWatchListLocalDataSource:
                FetchListOfMoviesInWatchListLocalDataSourceImpl(
                    localStorage: HiveStorage()),
            fetchListOfMoviesInWatchListRemoteDataSource:
                FetchListOfMoviesInWatchListRemoteDataSourceImpl(
              localStorage: HiveStorage(),
              databaseServices: FirebaseFirestoreService(
                  firebaseFirestore: FirebaseFirestore.instance),
            ),
            fetchListOfMoviesInHistoryRemoteDataSource:
                FetchListOfMoviesInHistoryRemoteDataSourceImpl(
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance),
                    localStorage: HiveStorage()),
            fetchListOfMoviesInHistoryLocalDataSource:
                FetchListOfMoviesInHistoryLocalDataSourceImpl(
              localStorage: HiveStorage(),
            ),
            updateUserDataRemoteDataSource: UpdateUserDataRemoteDataSourceImpl(
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance),
                localStorage: HiveStorage()),
            updateUserDataLocalDataSource:
                UpdateUserDataLocalDataSourceImpl(localStorage: HiveStorage()),
            userDataLocalDataSource:
                UserDataLocalDataSourceImpl(localStorage: HiveStorage()),
            fetchUserDataRemoteDataSource: FetchUserDataRemoteDataSourceImpl(
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance),
                localStorage: HiveStorage()),
            numberOfMoviesInWatchListLocalDataSource:
                NumberOfMoviesInWatchListLocalDataSourceImpl(
                    localStorage: HiveStorage()),
            fetchNumberOfMoviesInWatchListRemoteDataSource:
                FetchNumberOfMoviesInWatchListRemoteDataSourceImpl(
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance),
                    localStorage: HiveStorage()),
            connectivityService: ConnectivityService(),
            fetchNumberOfMoviesInHistoryRemoteDataSource:
                FetchNumberOfMoviesInHistoryRemoteDataSourceImpl(
                    localStorage: HiveStorage(),
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance)),
            numberOfMoviesInHistoryLocalDataSource:
                NumberOfMoviesInHistoryLocalDataSourceImpl(
                    localStorage: HiveStorage()))),
  );
  getIt.registerSingleton(
    FetchListOfMoviesInWatchListUseCase(
        profileRepo: ProfileRepoImpl(
            logOutDataSource: LogOutRemoteDataSourceImpl(
              localStorage: HiveStorage(),
              firebaseAuth: FirebaseAuth.instance,
              googleSignIn: GoogleSignIn(),
              facebookAuth: FacebookAuth.instance,
            ),
            fetchListOfMoviesInWatchListLocalDataSource:
                FetchListOfMoviesInWatchListLocalDataSourceImpl(
                    localStorage: HiveStorage()),
            fetchListOfMoviesInWatchListRemoteDataSource:
                FetchListOfMoviesInWatchListRemoteDataSourceImpl(
              localStorage: HiveStorage(),
              databaseServices: FirebaseFirestoreService(
                  firebaseFirestore: FirebaseFirestore.instance),
            ),
            fetchListOfMoviesInHistoryRemoteDataSource:
                FetchListOfMoviesInHistoryRemoteDataSourceImpl(
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance),
                    localStorage: HiveStorage()),
            fetchListOfMoviesInHistoryLocalDataSource:
                FetchListOfMoviesInHistoryLocalDataSourceImpl(
              localStorage: HiveStorage(),
            ),
            updateUserDataRemoteDataSource: UpdateUserDataRemoteDataSourceImpl(
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance),
                localStorage: HiveStorage()),
            updateUserDataLocalDataSource:
                UpdateUserDataLocalDataSourceImpl(localStorage: HiveStorage()),
            userDataLocalDataSource:
                UserDataLocalDataSourceImpl(localStorage: HiveStorage()),
            fetchUserDataRemoteDataSource: FetchUserDataRemoteDataSourceImpl(
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance),
                localStorage: HiveStorage()),
            numberOfMoviesInWatchListLocalDataSource:
                NumberOfMoviesInWatchListLocalDataSourceImpl(
                    localStorage: HiveStorage()),
            fetchNumberOfMoviesInWatchListRemoteDataSource:
                FetchNumberOfMoviesInWatchListRemoteDataSourceImpl(
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance),
                    localStorage: HiveStorage()),
            connectivityService: ConnectivityService(),
            fetchNumberOfMoviesInHistoryRemoteDataSource:
                FetchNumberOfMoviesInHistoryRemoteDataSourceImpl(
                    localStorage: HiveStorage(),
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance)),
            numberOfMoviesInHistoryLocalDataSource:
                NumberOfMoviesInHistoryLocalDataSourceImpl(
                    localStorage: HiveStorage()))),
  );

  getIt.registerSingleton(
    FetchListOfMoviesInHistoryUseCase(
        profileRepo: ProfileRepoImpl(
            logOutDataSource: LogOutRemoteDataSourceImpl(
              localStorage: HiveStorage(),
              firebaseAuth: FirebaseAuth.instance,
              googleSignIn: GoogleSignIn(),
              facebookAuth: FacebookAuth.instance,
            ),
            fetchListOfMoviesInWatchListLocalDataSource:
                FetchListOfMoviesInWatchListLocalDataSourceImpl(
                    localStorage: HiveStorage()),
            fetchListOfMoviesInWatchListRemoteDataSource:
                FetchListOfMoviesInWatchListRemoteDataSourceImpl(
              localStorage: HiveStorage(),
              databaseServices: FirebaseFirestoreService(
                  firebaseFirestore: FirebaseFirestore.instance),
            ),
            fetchListOfMoviesInHistoryRemoteDataSource:
                FetchListOfMoviesInHistoryRemoteDataSourceImpl(
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance),
                    localStorage: HiveStorage()),
            fetchListOfMoviesInHistoryLocalDataSource:
                FetchListOfMoviesInHistoryLocalDataSourceImpl(
              localStorage: HiveStorage(),
            ),
            updateUserDataRemoteDataSource: UpdateUserDataRemoteDataSourceImpl(
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance),
                localStorage: HiveStorage()),
            updateUserDataLocalDataSource:
                UpdateUserDataLocalDataSourceImpl(localStorage: HiveStorage()),
            userDataLocalDataSource:
                UserDataLocalDataSourceImpl(localStorage: HiveStorage()),
            fetchUserDataRemoteDataSource: FetchUserDataRemoteDataSourceImpl(
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance),
                localStorage: HiveStorage()),
            numberOfMoviesInWatchListLocalDataSource:
                NumberOfMoviesInWatchListLocalDataSourceImpl(
                    localStorage: HiveStorage()),
            fetchNumberOfMoviesInWatchListRemoteDataSource:
                FetchNumberOfMoviesInWatchListRemoteDataSourceImpl(
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance),
                    localStorage: HiveStorage()),
            connectivityService: ConnectivityService(),
            fetchNumberOfMoviesInHistoryRemoteDataSource:
                FetchNumberOfMoviesInHistoryRemoteDataSourceImpl(
                    localStorage: HiveStorage(),
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance)),
            numberOfMoviesInHistoryLocalDataSource:
                NumberOfMoviesInHistoryLocalDataSourceImpl(
                    localStorage: HiveStorage()))),
  );
  getIt.registerSingleton(
    FetchNumberOfWatchListMoviesUseCase(
        profileRepo: ProfileRepoImpl(
            logOutDataSource: LogOutRemoteDataSourceImpl(
              localStorage: HiveStorage(),
              firebaseAuth: FirebaseAuth.instance,
              googleSignIn: GoogleSignIn(),
              facebookAuth: FacebookAuth.instance,
            ),
            fetchListOfMoviesInWatchListLocalDataSource:
                FetchListOfMoviesInWatchListLocalDataSourceImpl(
                    localStorage: HiveStorage()),
            fetchListOfMoviesInWatchListRemoteDataSource:
                FetchListOfMoviesInWatchListRemoteDataSourceImpl(
              localStorage: HiveStorage(),
              databaseServices: FirebaseFirestoreService(
                  firebaseFirestore: FirebaseFirestore.instance),
            ),
            fetchListOfMoviesInHistoryRemoteDataSource:
                FetchListOfMoviesInHistoryRemoteDataSourceImpl(
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance),
                    localStorage: HiveStorage()),
            fetchListOfMoviesInHistoryLocalDataSource:
                FetchListOfMoviesInHistoryLocalDataSourceImpl(
              localStorage: HiveStorage(),
            ),
            updateUserDataRemoteDataSource: UpdateUserDataRemoteDataSourceImpl(
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance),
                localStorage: HiveStorage()),
            updateUserDataLocalDataSource:
                UpdateUserDataLocalDataSourceImpl(localStorage: HiveStorage()),
            userDataLocalDataSource:
                UserDataLocalDataSourceImpl(localStorage: HiveStorage()),
            fetchUserDataRemoteDataSource: FetchUserDataRemoteDataSourceImpl(
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance),
                localStorage: HiveStorage()),
            numberOfMoviesInWatchListLocalDataSource:
                NumberOfMoviesInWatchListLocalDataSourceImpl(
                    localStorage: HiveStorage()),
            fetchNumberOfMoviesInWatchListRemoteDataSource:
                FetchNumberOfMoviesInWatchListRemoteDataSourceImpl(
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance),
                    localStorage: HiveStorage()),
            connectivityService: ConnectivityService(),
            fetchNumberOfMoviesInHistoryRemoteDataSource:
                FetchNumberOfMoviesInHistoryRemoteDataSourceImpl(
                    localStorage: HiveStorage(),
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance)),
            numberOfMoviesInHistoryLocalDataSource:
                NumberOfMoviesInHistoryLocalDataSourceImpl(
                    localStorage: HiveStorage()))),
  );
  getIt.registerSingleton(
    FetchUserDataUseCase(
        profileRepo: ProfileRepoImpl(
            logOutDataSource: LogOutRemoteDataSourceImpl(
              localStorage: HiveStorage(),
              firebaseAuth: FirebaseAuth.instance,
              googleSignIn: GoogleSignIn(),
              facebookAuth: FacebookAuth.instance,
            ),
            fetchListOfMoviesInWatchListLocalDataSource:
                FetchListOfMoviesInWatchListLocalDataSourceImpl(
                    localStorage: HiveStorage()),
            fetchListOfMoviesInWatchListRemoteDataSource:
                FetchListOfMoviesInWatchListRemoteDataSourceImpl(
              localStorage: HiveStorage(),
              databaseServices: FirebaseFirestoreService(
                  firebaseFirestore: FirebaseFirestore.instance),
            ),
            fetchListOfMoviesInHistoryRemoteDataSource:
                FetchListOfMoviesInHistoryRemoteDataSourceImpl(
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance),
                    localStorage: HiveStorage()),
            fetchListOfMoviesInHistoryLocalDataSource:
                FetchListOfMoviesInHistoryLocalDataSourceImpl(
              localStorage: HiveStorage(),
            ),
            updateUserDataRemoteDataSource: UpdateUserDataRemoteDataSourceImpl(
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance),
                localStorage: HiveStorage()),
            updateUserDataLocalDataSource:
                UpdateUserDataLocalDataSourceImpl(localStorage: HiveStorage()),
            userDataLocalDataSource:
                UserDataLocalDataSourceImpl(localStorage: HiveStorage()),
            fetchUserDataRemoteDataSource: FetchUserDataRemoteDataSourceImpl(
                databaseServices: FirebaseFirestoreService(
                    firebaseFirestore: FirebaseFirestore.instance),
                localStorage: HiveStorage()),
            numberOfMoviesInWatchListLocalDataSource:
                NumberOfMoviesInWatchListLocalDataSourceImpl(
                    localStorage: HiveStorage()),
            fetchNumberOfMoviesInWatchListRemoteDataSource:
                FetchNumberOfMoviesInWatchListRemoteDataSourceImpl(
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance),
                    localStorage: HiveStorage()),
            connectivityService: ConnectivityService(),
            fetchNumberOfMoviesInHistoryRemoteDataSource:
                FetchNumberOfMoviesInHistoryRemoteDataSourceImpl(
                    localStorage: HiveStorage(),
                    databaseServices: FirebaseFirestoreService(
                        firebaseFirestore: FirebaseFirestore.instance)),
            numberOfMoviesInHistoryLocalDataSource:
                NumberOfMoviesInHistoryLocalDataSourceImpl(
                    localStorage: HiveStorage()))),
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
