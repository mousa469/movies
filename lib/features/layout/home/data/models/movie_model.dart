

import 'package:movies/features/layout/home/data/models/torrent.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  final int id;
  final String url;
  final String imdbCode;
  final String title;
  final String titleEnglish;
  final String titleLong;
  final String slug;
  final int year;
  final int runtime;
  final List<String> genres;
  final String ytTrailerCode;
  final String language;
  final String backgroundImage;
  final List<Torrent> torrents;

  MovieModel({
    required this.id,
    required this.url,
    required this.imdbCode,
    required this.title,
    required this.titleEnglish,
    required this.titleLong,
    required this.slug,
    required this.year,
    required this.runtime,
    required this.genres,
    required this.ytTrailerCode,
    required this.language,
    required this.backgroundImage,
    required this.torrents,
    required super.img,
    required super.rating,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json["id"],
      url: json["url"],
      imdbCode: json["imdb_code"],
      title: json["title"],
      titleEnglish: json["title_english"],
      titleLong: json["title_long"],
      slug: json["slug"],
      year: json["year"],
      runtime: json["runtime"],
      genres: List<String>.from(json["genres"] ?? []),
      ytTrailerCode: json["yt_trailer_code"],
      language: json["language"],
      backgroundImage: json["background_image"],
      torrents: (json["torrents"] as List?)?.map((e) => Torrent.fromJson(e)).toList() ?? [],
      img: json["medium_cover_image"],
      rating: json["rating"],
    );
  }

    Map<String, dynamic> toJson() {
    return {
      "id": id,
      "url": url,
      "imdb_code": imdbCode,
      "title": title,
      "title_english": titleEnglish,
      "title_long": titleLong,
      "slug": slug,
      "year": year,
      "runtime": runtime,
      "genres": genres,
      "yt_trailer_code": ytTrailerCode,
      "language": language,
      "background_image": backgroundImage,
      "torrents": torrents.map((torrent) => torrent.toJson()).toList(),
      "medium_cover_image": img,
      "rating": rating,
    };
  }
}

