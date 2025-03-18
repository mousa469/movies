import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsView extends StatelessWidget {
  static const String id = "movieDetails";

  const MovieDetailsView({super.key, required this.movie});
  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: movie.poster,
                    placeholder: (context, url) =>
                        Lottie.asset(Assets.animationsLoadingAnimation),
                    errorWidget: (context, url, error) =>
                        Lottie.asset(Assets.animationsError),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Year
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          movie.poster,
                          width: 100,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.titleLong,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 20),
                                SizedBox(width: 4),
                                Text(
                                  '${movie.rating}/10',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Genres
                  Wrap(
                    spacing: 8,
                    children: (movie.genres as List)
                        .map((genre) => Chip(
                              label: Text(genre,
                                  style: AppStyles.textStyle16Regular.copyWith(
                                      color: AppColors.secondaryBlackColor)),
                              backgroundColor: Colors.blue[100],
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 16),

                  // Runtime and Language
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer, size: 20),
                          SizedBox(width: 4),
                          Text('${movie.runTime} min'),
                        ],
                      ),
                      Text('Language: ${movie.language.toUpperCase()}'),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Trailer Button
                  if (movie.youtubeTrailerCode.isNotEmpty)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final Uri url = Uri.parse(
                              'https://www.youtube.com/watch?v=${movie.youtubeTrailerCode}');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url,
                                mode: LaunchMode.externalApplication);
                          }
                        },
                        icon: Icon(Icons.play_arrow,
                            color: AppColors.secondaryBlackColor),
                        label: Text('Watch Trailer',
                            style: AppStyles.textStyle20Bold.copyWith(
                                color: AppColors.secondaryBlackColor)),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.kPrimaryColor,
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  SizedBox(height: 16),

                  // Visit Site Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final Uri url = Uri.parse(movie.url);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url,
                              mode: LaunchMode.externalApplication);
                        }
                      },
                      child: Text(
                        'Visit Movie Page',
                        style: AppStyles.textStyle20Bold
                            .copyWith(color: AppColors.secondaryBlackColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kPrimaryColor,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




















































// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class Test extends StatelessWidget {
//   static const String id = "test"; // Added static ID for navigation

//   final Map<String, dynamic> movie = {
//     "title": "Curse of the Seven Oceans",
//     "year": 2024,
//     "rating": 5.7,
//     "runtime": 94,
//     "genres": ["Horror", "Thriller"],
//     "yt_trailer_code": "1Wz4r3758CY",
//     "large_cover_image": "https://yts.mx/assets/images/movies/curse_of_the_seven_oceans_2024/large-cover.jpg",
//     "torrents": [
//       {
//         "quality": "720p",
//         "size": "865.45 MB",
//       },
//       {
//         "quality": "1080p",
//         "size": "1.74 GB",
//       }
//     ],
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(movie["title"]),
//         backgroundColor: Colors.black,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               color: Colors.black,
//               padding: EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: CachedNetworkImage(
//                       imageUrl: movie["large_cover_image"],
//                       height: 250,
//                       width: 170,
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) => CircularProgressIndicator(),
//                       errorWidget: (context, url, error) => Icon(Icons.error),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "${movie["title"]} (${movie["year"]})",
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                   SizedBox(height: 5),
//                   Row(
//                     children: [
//                       Icon(Icons.star, color: Colors.yellow),
//                       SizedBox(width: 5),
//                       Text("${movie["rating"]}/10", style: TextStyle(color: Colors.white)),
//                       Spacer(),
//                       Text("${movie["runtime"]} min", style: TextStyle(color: Colors.white)),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: movie["genres"].map<Widget>((genre) {
//                         return Container(
//                           margin: EdgeInsets.symmetric(horizontal: 5),
//                           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                           decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: Text(genre, style: TextStyle(color: Colors.white)),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Center(
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         final url = "https://www.youtube.com/watch?v=${movie["yt_trailer_code"]}";
//                         print("Opening trailer: $url");
//                       },
//                       icon: Icon(Icons.play_arrow),
//                       label: Text("Watch Trailer"),
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text("Available Downloads:", style: TextStyle(color: Colors.white, fontSize: 16)),
//                   Column(
//                     children: movie["torrents"].map<Widget>((torrent) {
//                       return ListTile(
//                         leading: Icon(Icons.download, color: Colors.white),
//                         title: Text("${torrent["quality"]} - ${torrent["size"]}", style: TextStyle(color: Colors.white)),
//                         onTap: () {
//                           print("Downloading: ${torrent["quality"]}");
//                         },
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }