import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/constants.dart';
import 'package:movies/core/services/get_it_services.dart';
import 'package:movies/features/authentication/domain/use_cases/create_new_user_use_case.dart';
import 'package:movies/features/authentication/presentation/sign_up_cubit/sign_up_cubit.dart';
import 'package:movies/features/authentication/presentation/views/widgets/authCustomAppBar.dart';
import 'package:movies/features/authentication/presentation/views/widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  static const String id = '/registerView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(getIt<CreateNewUserUseCase>()),
      child: Scaffold(
        appBar: AuthCustomAppBar(
          title: register,
        ),
        body: const RegisterViewBody(),
      ),
    );
  }
}
