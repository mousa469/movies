import 'package:flutter/foundation.dart';
import 'package:movies/features/layout/home/domain/entities/cast.dart';
import 'package:movies/features/layout/home/domain/entities/movie_details_entity.dart';

class MovieDetailsModel extends MovieDetailsEntity {
  final String language;
  final String largeScreenshotImage1;
  final String largeScreenshotImage2;
  final String largeScreenshotImage3;
  final String dateUploaded;
  final String imdbCode;

  MovieDetailsModel({
    required super.backgroundImg,
    required this.dateUploaded,
    required this.language,
    required this.imdbCode,
    required this.largeScreenshotImage3,
    required this.largeScreenshotImage2,
    required this.largeScreenshotImage1,
    required super.id,
    required super.url,
    required super.title,
    required super.year,
    required super.rating,
    required super.runTime,
    required super.genres,
    required super.likeCount,
    required super.descriptionIntro,
    required super.youtubeTrailerCode,
    required super.screenShots,
    required super.cast,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    List<String> screens = json.entries
        .where((entry) => entry.key.contains("medium_screenshot_image"))
        .map((entry) => entry.value as String)
        .toList();
    return MovieDetailsModel(
      screenShots: screens,
      backgroundImg: json["medium_cover_image"] ?? '',
      dateUploaded: json['date_uploaded'] ?? "",
      language: json['language'] ?? "",
      imdbCode: json['imdb_code'] ?? "",
      largeScreenshotImage3: json['large_screenshot_image3'] ?? "",
      largeScreenshotImage2: json['large_screenshot_image2'] ?? "",
      largeScreenshotImage1: json['large_screenshot_image1'] ?? "",
      id: (json['id'] ?? 0) as int,
      url: json['url'] ?? "",
      title: json['title'] ?? "",
      year: (json['year'] ?? 0) as int,
      rating: json['rating']?.toDouble() ?? 0.0, // Ensures it's a double
      runTime: (json['runtime'] ?? 0) as int,
      genres: (json['genres'] as List<dynamic>?)?.cast<String>() ?? [],
      likeCount: (json['like_count'] ?? 0) as int,
      descriptionIntro: json['description_intro'] ?? "",
      youtubeTrailerCode: json['yt_trailer_code'] ?? "",
      cast: (json['cast'] as List<dynamic>?)
              ?.map(
                  (actor) => Cast.fromJson(json: actor as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "medium_cover_image": backgroundImg,
      'date_uploaded': dateUploaded,
      'language': language,
      'imdb_code': imdbCode,
      'large_screenshot_image3': largeScreenshotImage3,
      'large_screenshot_image2': largeScreenshotImage2,
      'large_screenshot_image1': largeScreenshotImage1,
      'id': id,
      'url': url,
      'title': title,
      'year': year,
      'rating': rating,
      'runtime': runTime,
      'genres': genres,
      'like_count': likeCount,
      'description_intro': descriptionIntro,
      'yt_trailer_code': youtubeTrailerCode,
      "screenShots": screenShots,
      'cast': cast.map((actor) => actor.toJson()).toList(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovieDetailsModel &&
          other.id == id &&
          other.url == url &&
          other.title == title &&
          other.year == year &&
          other.rating == rating &&
          other.runTime == runTime &&
          listEquals(other.genres, genres) &&
          other.likeCount == likeCount &&
          other.descriptionIntro == descriptionIntro &&
          other.youtubeTrailerCode == youtubeTrailerCode &&
          listEquals(other.screenShots, screenShots) &&
          listEquals(other.cast, cast) &&
          other.backgroundImg == backgroundImg &&
          other.language == language &&
          other.largeScreenshotImage1 == largeScreenshotImage1 &&
          other.largeScreenshotImage2 == largeScreenshotImage2 &&
          other.largeScreenshotImage3 == largeScreenshotImage3 &&
          other.dateUploaded == dateUploaded &&
          other.imdbCode == imdbCode);

  @override
  int get hashCode =>
      id.hashCode ^
      url.hashCode ^
      title.hashCode ^
      year.hashCode ^
      rating.hashCode ^
      runTime.hashCode ^
      genres.hashCode ^
      likeCount.hashCode ^
      descriptionIntro.hashCode ^
      youtubeTrailerCode.hashCode ^
      screenShots.hashCode ^
      cast.hashCode ^
      backgroundImg.hashCode ^
      language.hashCode ^
      largeScreenshotImage1.hashCode ^
      largeScreenshotImage2.hashCode ^
      largeScreenshotImage3.hashCode ^
      dateUploaded.hashCode ^
      imdbCode.hashCode;
}
