import 'package:flutter/material.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/extensions/media_query_extension.dart';
import 'package:movies/features/authentication/presentation/views/widgets/login_form.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.screenWidth(0.040)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                Assets.imagesMoviesLogo,
                height: context.screenHeight(.2),
              ),
              LoginForm()
            ],
          ),
        ),
      ),
    );
  }
}
