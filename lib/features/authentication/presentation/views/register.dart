import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:movies/features/authentication/presentation/views/widgets/authCustomAppBar.dart';
import 'package:movies/features/authentication/presentation/views/widgets/register_view_body.dart';
import 'package:movies/generated/l10n.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  static const String id = '/registerView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        appBar: AuthCustomAppBar(
          title: S.of(context).register,
        ),
        body: const RegisterViewBody(),
      ),
    );
  }
}
