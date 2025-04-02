import 'package:flutter/material.dart';
import 'package:movies/core/widgets/movie_details_body.dart';


class MovieDetailsView extends StatelessWidget {
  static const String id = "movieDetails";

  const MovieDetailsView({super.key, required this.movieID});

  final int movieID ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MovieDetailsBody(movieID:movieID ,));
  }
}

