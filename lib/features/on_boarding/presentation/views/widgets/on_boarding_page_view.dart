import 'package:flutter/material.dart';
import 'package:movies/core/extensions/media_query_extension.dart';
import 'package:movies/features/on_boarding/model/on_boarding_model.dart';
import 'package:movies/features/on_boarding/presentation/views/widgets/on_boarding_item.dart';

class OnBoardingPageView extends StatefulWidget {
  const OnBoardingPageView(
      {super.key, required this.currentIndex, required this.onPageChanged});
  final int currentIndex;
  final void Function(int)? onPageChanged;

  @override
  State<OnBoardingPageView> createState() => _OnBoardingPageViewState();
}

class _OnBoardingPageViewState extends State<OnBoardingPageView> {
  final PageController pageController = PageController();
  @override
  void didUpdateWidget(covariant OnBoardingPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      pageController.animateToPage(
        widget.currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight(.9),
      child: PageView.builder(
          onPageChanged: widget.onPageChanged,
          controller: pageController,
          itemCount: OnBoardingModel.onBoardingList.length,
          itemBuilder: (context, index) {
            return OnBoardingItem(
              onBoardingModel: OnBoardingModel.onBoardingList[index],
            );
          }),
    );
  }
}
