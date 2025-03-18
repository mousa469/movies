import 'package:flutter/material.dart';
import 'package:movies/core/extensions/media_query_extension.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/presentation/widgets/available_movies_background_img.dart';
import 'package:movies/features/layout/home/presentation/widgets/movies_swiper.dart';

class AvailableMoviesSection extends StatefulWidget {
  const AvailableMoviesSection({super.key, required this.movies});
  final List<MovieEntity> movies;

  @override
  State<AvailableMoviesSection> createState() => _AvailableMoviesSectionState();
}

class _AvailableMoviesSectionState extends State<AvailableMoviesSection> {
  late String backImg;

  @override
  void initState() {
    super.initState();
    backImg = widget.movies[0].poster;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight(.7),
      child: Stack(
        children: [
          AvailableMoviesBackgroundImg(backImg: backImg),
          Container(
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1E1E1E).withValues(alpha: 0.6),
                  Color(0xFF121312).withValues(alpha: .8),
                  Color(0xFF121312).withValues(alpha: .9),
                  Color(0xFF121312).withValues(alpha: 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          MoviesSwiper(
            movies: widget.movies,
            onIndexChanged: (value) {
              setState(() {
                backImg = widget.movies[value].poster;
              });
            },
          )
        ],
      ),
    );
  }
}
// class AvailableMoviesSection extends StatefulWidget {
//   const AvailableMoviesSection({super.key, required this.movies});
//   final List<MovieEntity> movies;

//   @override
//   State<AvailableMoviesSection> createState() => _AvailableMoviesSectionState();
// }

// class _AvailableMoviesSectionState extends State<AvailableMoviesSection> {
//   late String backImg;

//   @override
//   void initState() {
//     super.initState();
//     backImg = widget.movies[0].img;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: context.screenHeight(.7),
//       child: Stack(
//         children: [
//           CachedNetworkImage(
//             fit: BoxFit.fill,
//             width: double.infinity,
//             imageUrl: backImg,
//             placeholder: (context, url) =>
//                 Lottie.asset(Assets.animationsLoadingAnimation),
//             errorWidget: (context, url, error) =>
//                 Lottie.asset(Assets.animationsError),
//           ),
//           Container(
//             foregroundDecoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xFF1E1E1E).withValues(alpha: 0.6),
//                   Color(0xFF121312).withValues(alpha: .8),
//                   Color(0xFF121312).withValues(alpha: .9),
//                   Color(0xFF121312).withValues(alpha: 1),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//           Column(
//             children: [
//               Image.asset(Assets.imagesAvailableNowBetter)
//                   .symmetricPadding(horizontalValue: 24, verticalValue: 16),
//               CarouselWidget(
//                 movies: widget.movies,
//                 infiniteScroll: true,
//                 autoPlay: false,
//                 height: context.screenHeight(0.3766),
//                 onPageChanged: (index, p1) {
//                   setState(() {
//                     backImg = widget.movies[index].img;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
