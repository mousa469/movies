import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/extensions/media_query_extension.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/on_boarding/model/on_boarding_model.dart';

class OnBoardingNavigator extends StatefulWidget {
  const OnBoardingNavigator(
      {super.key,
      required this.currentIndex,
      required this.increaseIndex,
      required this.decreaseIndex});
  final int currentIndex;
  final VoidCallback increaseIndex;
  final VoidCallback decreaseIndex;

  @override
  State<OnBoardingNavigator> createState() => _OnBoardingNavigatorState();
}

class _OnBoardingNavigatorState extends State<OnBoardingNavigator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight(.1),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          // color: Colors.red,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Row(
        children: [
          Visibility(
            visible: widget.currentIndex != 0,
            maintainAnimation: true,
            maintainSize: true,
            maintainState: true,
            child: InkWell(
              onTap: widget.decreaseIndex,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColors.kPrimaryColor),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.kPrimaryColor,
                ),
              ),
            ),
          ),
          Spacer(),
          DotsIndicator(
            dotsCount: OnBoardingModel.onBoardingList.length,
            position: widget.currentIndex.toDouble(),
            decorator: DotsDecorator(
              activeColor: AppColors.kPrimaryColor,
              color: AppColors.kPrimaryColor.withValues(alpha: .3),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: widget.increaseIndex,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppColors.kPrimaryColor),
              ),
              child: Icon(
                Icons.arrow_forward,
                color: AppColors.kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
