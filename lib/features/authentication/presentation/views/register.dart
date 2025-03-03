import 'package:flutter/material.dart';
import 'package:movies/features/authentication/presentation/views/widgets/authCustomAppBar.dart';
import 'package:movies/features/authentication/presentation/views/widgets/register_view_body.dart';
import 'package:movies/generated/l10n.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  static const String id = '/registerView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthCustomAppBar(
      title: S.of(context).register,
      ),
      body: const RegisterViewBody(),
    );
  }
}

