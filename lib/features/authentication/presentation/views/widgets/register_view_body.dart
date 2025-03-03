import 'package:flutter/material.dart';
import 'package:movies/core/extensions/media_query_extension.dart';
import 'package:movies/core/extensions/space_extension.dart';
import 'package:movies/features/authentication/presentation/views/widgets/authentication_custom_app_bar.dart';
import 'package:movies/features/authentication/presentation/views/widgets/register_form.dart';
import 'package:movies/generated/l10n.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.screenWidth(0.040)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            20.verticalSpace(),
            // LoginForm(),
            RegisterForm(),
          ],
        ),
      ),
    );
  }
}
