class MovieEntity {
  final String img;
  final num rating;

  MovieEntity({required this.img, required this.rating});

  // factory MovieEntity.fromJson(Map<String, dynamic> json) {
  //   return MovieEntity(img: json["medium_cover_image"], rating: json["rating"]);
  // }
}
