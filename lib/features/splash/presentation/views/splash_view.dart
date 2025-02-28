import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/extensions/media_query_extension.dart';
import 'package:movies/core/extensions/routing_extension.dart';
import 'package:movies/features/on_boarding/presentation/views/on_boarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static const String id = "splash";

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      context.pushReplacementNamed(OnBoardingView.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ZoomIn(
          duration: Duration(milliseconds: 1500),
          child: Image.asset(
            Assets.imagesMoviesLogo,
            width: context.screenWidth(.2),
            height: context.screenHeight(.2),
          ),
        ),
      ),
    );
  }
}
