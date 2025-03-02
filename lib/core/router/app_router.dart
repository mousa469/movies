import 'package:flutter/material.dart';
import 'package:movies/features/authentication/presentation/views/login_view.dart';
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
