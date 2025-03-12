import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/core/services/api_services.dart';
import 'package:movies/core/services/firbase_auth_services.dart';
import 'package:movies/features/authentication/data/data_source/auth_local_data_source.dart';
import 'package:movies/features/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:movies/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:movies/features/authentication/domain/use_cases/create_new_user_use_case.dart';
import 'package:movies/features/authentication/domain/use_cases/sign_in_User_use_case.dart';
import 'package:movies/features/authentication/domain/use_cases/sign_in_with_facebook_use_case.dart';
import 'package:movies/features/authentication/domain/use_cases/sign_in_with_google_use_case.dart';
import 'package:movies/features/layout/home/data/datasources/availabe_movies_remote_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/available_movies_local_data_source.dart';
import 'package:movies/features/layout/home/data/repositories/home_repo_impl.dart';
import 'package:movies/features/layout/home/domain/usecases/fetch_available_movies_use_case.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<CreateNewUserUseCase>(CreateNewUserUseCase(
      authRepository: AuthRepositoryImpl(
          authRemoteDataSource: AuthRemoteDataSourceImpl(
              firebaseAuthServices:
                  FirebaseAuthServices(firebaseAuth: FirebaseAuth.instance),
              firebaseFirestore: FirebaseFirestore.instance),
          authLocalDataSource: AuthLocalDataSourceImpl())));

  getIt.registerSingleton(
    FetchAvailableMoviesUseCase(
      homeRepo: HomeRepoImpl(
        availabeMoviesRemoteDataSource: AvailabeMoviesRemoteDataSourceImp(
          apiService: ApiService(Dio()),
        ),
        availableMoviesLocalDataSource: AvailableMoviesLocalDataSourceImpl(),
      ),
    ),
  );

  getIt.registerSingleton(
    SignInUserUseCase(
      authRepository: AuthRepositoryImpl(
        authRemoteDataSource: AuthRemoteDataSourceImpl(
            firebaseAuthServices:
                FirebaseAuthServices(firebaseAuth: FirebaseAuth.instance),
            firebaseFirestore: FirebaseFirestore.instance),
        authLocalDataSource: AuthLocalDataSourceImpl(),
      ),
    ),
  );

  getIt.registerSingleton(
    SignInWithGoogleUseCase(
      authRepository: AuthRepositoryImpl(
        authRemoteDataSource: AuthRemoteDataSourceImpl(
            firebaseAuthServices:
                FirebaseAuthServices(firebaseAuth: FirebaseAuth.instance),
            firebaseFirestore: FirebaseFirestore.instance),
        authLocalDataSource: AuthLocalDataSourceImpl(),
      ),
    ),
  );
  getIt.registerSingleton(
    SignInWithFacebookUseCase(
      authRepository: AuthRepositoryImpl(
        authRemoteDataSource: AuthRemoteDataSourceImpl(
            firebaseAuthServices:
                FirebaseAuthServices(firebaseAuth: FirebaseAuth.instance),
            firebaseFirestore: FirebaseFirestore.instance),
        authLocalDataSource: AuthLocalDataSourceImpl(),
      ),
    ),
  );
}
