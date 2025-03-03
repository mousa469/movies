import 'package:flutter/material.dart';
import 'package:movies/features/authentication/presentation/views/login_view.dart';
import 'package:movies/features/authentication/presentation/views/register.dart';
import 'package:movies/features/authentication/presentation/views/reset_password_view.dart';
import 'package:movies/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:movies/features/splash/presentation/views/splash_view.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashView.id:
        return MaterialPageRoute(builder: (context) => SplashView());
      case OnBoardingView.id:
        return MaterialPageRoute(builder: (context) => OnBoardingView());
      case LoginView.id:
        return MaterialPageRoute(builder: (context) => LoginView());
      case RegisterView.id:
        return MaterialPageRoute(builder: (context) => RegisterView());
      case ResetPasswordView.id:
        return MaterialPageRoute(builder: (context) => ResetPasswordView());
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text("there is no route exist for this string"),
            ),
          ),
        );
    }
  }
}
