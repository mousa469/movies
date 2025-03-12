// import 'package:flutter/material.dart';
// import 'package:movies/core/assets/app_assets.dart';
// import 'package:movies/core/extensions/media_query_extension.dart';
// import 'package:movies/core/extensions/padding_extension.dart';
// import 'package:movies/features/layout/home/presentation/widgets/movies_item.dart';

// class WatchNowListViewBuilder extends StatelessWidget {
//   const WatchNowListViewBuilder({super.key});
//   final List<String> imgs = const [
//     Assets.imagesOnBoardingBackImg1,
//     Assets.imagesOnBoardingBackImg2,
//     Assets.imagesOnBoardingBackImg3,
//     Assets.imagesOnBoardingBackImg4,
//     Assets.imagesOnBoardingBackImg5,
//     Assets.imagesOnBoardingBackImg6,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: context.screenHeight(.3),
//       child: ListView.builder(
//         itemCount: imgs.length,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           return MoviesItem(
//             height: context.screenHeight(0.236),
//             width: context.screenWidth(0.3395),
//             img: imgs[index],
//           ).customePadding(left: 16);
//         },
//       ),
//     );
//   }
// }
