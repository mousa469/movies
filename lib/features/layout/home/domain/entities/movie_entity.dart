import 'package:movies/features/layout/home/data/models/torrent.dart';

class MovieEntity {
  final String url;
  final String youtubeTrailerCode;
  final int year;
  final num runTime;
  final int id;
  final String poster;
  final num rating;
  final String titleLong;
  final List<String> genres;
  final String language;
  final List<Torrent> torrents;

  MovieEntity({

    required this.youtubeTrailerCode,
    required this.year,
    required this.url,
    required this.runTime,
    required this.id,
    required this.poster,
    required this.rating,
    required this.genres,
    required this.titleLong,
    required this.language,
    required this.torrents,
  });

  factory MovieEntity.fromJson(Map<String, dynamic> json) {
    return MovieEntity(
      url:json["url"] as String? ?? "" ,
      youtubeTrailerCode: json["yt_trailer_code"] as String? ?? "",
      year: json["year"] as int? ?? 0,
      runTime: json["runtime"] as num? ?? 0,
      id: json["id"] as int? ?? 0,
      poster: json["medium_cover_image"] as String? ?? "",
      rating: json["rating"] as num? ?? 0,
      genres: (json["genres"] as List?)?.map((e) => e as String).toList() ?? [],
      titleLong: json["title_long"] as String? ?? "",
      language: json["language"] as String? ?? "",
      torrents: (json["torrents"] as List?)
              ?.map((t) => Torrent.fromJson(t as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "url" : url ,
      "yt_trailer_code": youtubeTrailerCode,
      "year": year,
      "runtime": runTime,
      "id": id,
      "medium_cover_image": poster,
      "rating": rating,
      "title_long": titleLong,
      "genres": genres,
      "language": language,
      "torrents": torrents.map((t) => t.toJson()).toList(),
    };
  }
}
