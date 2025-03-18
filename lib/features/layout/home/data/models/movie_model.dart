import 'package:movies/features/layout/home/data/models/torrent.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  final String imdbCode;
  final String title;
  final String titleEnglish;
  final String slug;

  MovieModel({
    required super.youtubeTrailerCode,
    required super.runTime,
    required super.id,
    required super.url,
    required this.imdbCode,
    required this.title,
    required this.titleEnglish,
    required super.titleLong,
    required this.slug,
    required super.year,
    required super.genres,
    required super.language,
    required super.poster,
    required super.torrents,
    required super.rating,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      runTime: json["runtime"] as int? ?? 0,
      id: json["id"] as int? ?? 0,
      url: json["url"] as String? ?? "",
      imdbCode: json["imdb_code"] as String? ?? "",
      title: json["title"] as String? ?? "",
      titleEnglish: json["title_english"] as String? ?? "",
      titleLong: json["title_long"] as String? ?? "",
      slug: json["slug"] as String? ?? "",
      year: json["year"] as int? ?? 0,
      genres: (json["genres"] as List?)?.map((e) => e as String).toList() ?? [],
      youtubeTrailerCode: json["yt_trailer_code"] as String? ?? "",
      language: json["language"] as String? ?? "",
      poster: json["medium_cover_image"] as String? ?? "",
      torrents: (json["torrents"] as List?)
              ?.map((e) => Torrent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      rating: (json["rating"] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "runtime": runTime,
      "id": id,
      "url": url,
      "imdb_code": imdbCode,
      "title": title,
      "title_english": titleEnglish,
      "title_long": titleLong,
      "slug": slug,
      "year": year,
      "genres": genres,
      "yt_trailer_code": youtubeTrailerCode,
      "language": language,
      "medium_cover_image": poster,
      "torrents": torrents.map((torrent) => torrent.toJson()).toList(),
      "rating": rating,
    };
  }
}
