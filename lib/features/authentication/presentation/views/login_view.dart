import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/services/get_it_services.dart';
import 'package:movies/features/authentication/domain/use_cases/sign_in_User_use_case.dart';
import 'package:movies/features/authentication/domain/use_cases/sign_in_with_facebook_use_case.dart';
import 'package:movies/features/authentication/domain/use_cases/sign_in_with_google_use_case.dart';
import 'package:movies/features/authentication/presentation/sign_in_cubit/sign_in_cubit.dart';
import 'package:movies/features/authentication/presentation/views/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static const String id = "/LoginView";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit( signInUserUseCase: getIt<SignInUserUseCase>() , signInWithGoogleUseCase: getIt<SignInWithGoogleUseCase>() , signInWithFacebookUseCase: getIt<SignInWithFacebookUseCase>()),
      child: const Scaffold(
        body: LoginViewBody(),
      ),
    );
  }
}
