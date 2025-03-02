import 'package:flutter/material.dart';
import 'package:movies/core/extensions/media_query_extension.dart';
import 'package:movies/core/extensions/space_extension.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/features/on_boarding/model/on_boarding_model.dart';

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem({
    super.key,
    required this.onBoardingModel,
  });
  final OnBoardingModel onBoardingModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: context.screenHeight(1),
          width: double.infinity,
          child: Image.asset(
            onBoardingModel.backgroungImage,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          height: context.screenHeight(1),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: onBoardingModel.colors!
                ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: context.screenHeight(1),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                textAlign: TextAlign.center,
                onBoardingModel.title,
                style: AppStyles.textStyle24Bold,
              ),
              16.verticalSpace(),
              onBoardingModel.subTitle != null
                  ? Text(
                      textAlign: TextAlign.center,
                      onBoardingModel.subTitle ?? '',
                      style: AppStyles.textStyle16Regular
                          .copyWith(color: AppColors.grayColor),
                    )
                  : Container(),
            ],
          ),
        )
      ],
    );
  }
}
