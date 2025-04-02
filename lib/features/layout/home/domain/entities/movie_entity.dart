import 'package:hive/hive.dart';

part 'movie_entity.g.dart';

@HiveType(typeId: 4)
class MovieEntity extends HiveObject {
  @HiveField(0)
  final num id;

  @HiveField(1)
  final num rating;

  @HiveField(2)
  final String mediumCoverImage;

  MovieEntity({
    required this.mediumCoverImage,
    required this.id,
    required this.rating,
  });

  factory MovieEntity.fromJson(Map<String, dynamic> json) {
    return MovieEntity(
      mediumCoverImage: json["medium_cover_image"] ??
          "https://t4.ftcdn.net/jpg/04/00/24/31/360_F_400243185_BOxON3h9avMUX10RsDkt3pJ8iQx72kS3.jpg",
      id: json["id"] ?? 0 as num,
      rating: json["rating"] ?? 0 as num,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "medium_cover_image": mediumCoverImage,
      "id": id,
      "rating": rating,
    };
  }
}













// class MovieEntity {
//   final num id;
//   final num rating;
//   final String mediumCoverImage;

//   MovieEntity({required this.mediumCoverImage, required this.id, required this.rating});

//   factory MovieEntity.fromJson(Map<String, dynamic> json) {
//     return MovieEntity(
//       mediumCoverImage: json["medium_cover_image"],
//       id: json["id"] ?? 0 as num,
//       rating: json["rating"] ?? 0 as num,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "medium_cover_image" : mediumCoverImage ,
//       "id": id,
//       "rating": rating,
//     };
//   }
// }
