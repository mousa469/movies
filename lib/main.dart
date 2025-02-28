import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies/core/router/app_router.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/splash/presentation/views/splash_view.dart';
import 'package:movies/generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
      initialRoute: SplashView.id,
      onGenerateRoute: AppRouter.onGenerateRoute,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.secondaryBlackColor,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple , brightness: Brightness.dark),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
    );
  }
}
