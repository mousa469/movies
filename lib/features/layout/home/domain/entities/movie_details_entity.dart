import 'package:movies/features/layout/home/domain/entities/cast.dart';

class MovieDetailsEntity {
  final String backgroundImg;
  final num id;
  final String url;
  final String title;
  final num year;
  final num rating;
  final num runTime;
  final List<String> genres;
  final num likeCount;
  final String descriptionIntro;
  final String youtubeTrailerCode;
  final List<String> screenShots;
  final List<Cast> cast;

  MovieDetailsEntity({
    required this.backgroundImg,
    required this.id,
    required this.url,
    required this.title,
    required this.year,
    required this.rating,
    required this.runTime,
    required this.genres,
    required this.likeCount,
    required this.descriptionIntro,
    required this.youtubeTrailerCode,
    required this.screenShots,
    required this.cast,
  });

  factory MovieDetailsEntity.fromJson({required Map<String, dynamic> json}) {
    List<String> screens = json.entries
        .where((entry) => entry.key.contains("medium_screenshot_image"))
        .map((entry) => entry.value as String)
        .toList();
        
    return MovieDetailsEntity(
      screenShots: screens,
      backgroundImg: json["medium_cover_image"] ?? "",
      id: json["id"] ?? 0,
      url: json["url"] ?? "",
      title: json["title"] ?? "",
      year: json["year"] ?? 0,
      rating: json["rating"] ?? 0,
      runTime: json["runtime"] ?? 0,
      genres: (json["genres"] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ?? 
          [],
      likeCount: json["like_count"] ?? 0,
      descriptionIntro: json["description_intro"] ?? "",
      youtubeTrailerCode: json["yt_trailer_code"] ?? "",
      cast: (json["cast"] as List<dynamic>?)
              ?.map((cast) => Cast.fromJson(json: cast as Map<String, dynamic>))
              .toList() ?? 
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "medium_cover_image": backgroundImg,
      "id": id,
      "url": url,
      "title": title,
      "year": year,
      "rating": rating,
      "runtime": runTime,
      "genres": genres,
      "like_count": likeCount,
      "description_intro": descriptionIntro,
      "yt_trailer_code": youtubeTrailerCode,
      "cast": cast.map((c) => c.toJson()).toList(),
    };
  }
}











// import 'package:movies/features/layout/home/domain/entities/cast.dart';

// class MovieDetailsEntity {
//   final String backgroundImg;
//   final num id;
//   final String url;
//   final String title;
//   final num year;
//   final num rating;
//   final num runTime;
//   final List<String> genres;
//   final num likeCount;
//   final String descriptionIntro;
//   final String youtubeTrailerCode;
//   final List<String> screenShots;
//   final List<Cast> cast;

//   MovieDetailsEntity({
//     required this.backgroundImg,
//     required this.id,
//     required this.url,
//     required this.title,
//     required this.year,
//     required this.rating,
//     required this.runTime,
//     required this.genres,
//     required this.likeCount,
//     required this.descriptionIntro,
//     required this.youtubeTrailerCode,
//     required this.screenShots,
//     required this.cast,
//   });

//   factory MovieDetailsEntity.fromJson({required Map<String, dynamic> json}) {
//     List<String> screens = json.entries
//         .where((entry) => entry.key.contains("medium_screenshot_image"))
//         .map((entry) => entry.value as String)
//         .toList();
//     return MovieDetailsEntity(
//       screenShots: screens,
//       backgroundImg: json["medium_cover_image"] ?? "",
//       id: json["id"] ?? 0,
//       url: json["url"] ?? "",
//       title: json["title"] ?? "",
//       year: json["year"] ?? 0,
//       rating: json["rating"] ?? 0,
//       runTime: json["runtime"] ?? 0,
//       genres: (json["genres"] as List<dynamic>?)
//               ?.map((e) => e.toString())
//               .toList() ??
//           [],
//       likeCount: json["like_count"] ?? 0,
//       descriptionIntro: json["description_intro"] ?? "",
//       youtubeTrailerCode: json["yt_trailer_code"] ?? "",
//       cast: (json["cast"] as List<dynamic>?)
//               ?.map((cast) => Cast.fromJson(json: cast as Map<String, dynamic>))
//               .toList() ??
//           [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "medium_cover_image": backgroundImg,
//       "id": id,
//       "url": url,
//       "title": title,
//       "year": year,
//       "rating": rating,
//       "runtime": runTime,
//       "genres": genres,
//       "like_count": likeCount,
//       "description_intro": descriptionIntro,
//       "yt_trailer_code": youtubeTrailerCode,
//       "cast": cast.map((c) => c.toJson()).toList(),
//     };
//   }
// }
