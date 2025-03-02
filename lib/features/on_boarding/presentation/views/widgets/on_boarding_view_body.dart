import 'package:flutter/material.dart';
import 'package:movies/core/extensions/routing_extension.dart';
import 'package:movies/core/services/shared_prefs.dart';
import 'package:movies/features/authentication/presentation/views/login_view.dart';
import 'package:movies/features/on_boarding/model/on_boarding_model.dart';
import 'package:movies/features/on_boarding/presentation/views/widgets/on_boarding_navigator.dart';
import 'package:movies/features/on_boarding/presentation/views/widgets/on_boarding_page_view.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  int currentIndex = 0;

  void onPageChanged(index) {
    setState(() {
      currentIndex = index;
    });
  }

  void increaseIndex() {
    setState(() {
      if (currentIndex < OnBoardingModel.onBoardingList.length - 1) {
        currentIndex++;
        return;
      }

      if (currentIndex == OnBoardingModel.onBoardingList.length - 1) {
        SharedPrefs.setBool(SharedPrefs.isOnBoardingSeenBefore, true);
        context.pushReplacementNamed(LoginView.id);
      }
    });
  }

  void decreaseIndex() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          OnBoardingPageView(
            onPageChanged: onPageChanged,
            currentIndex: currentIndex,
          ),
          OnBoardingNavigator(
            decreaseIndex: decreaseIndex,
            increaseIndex: increaseIndex,
            currentIndex: currentIndex,
          ),
        ],
      ),
    );
  }
}
