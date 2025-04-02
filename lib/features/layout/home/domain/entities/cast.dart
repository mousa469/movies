class Cast {
  final String name;
  final String characterName;
  final String characterImg;

  Cast(
      {required this.name,
      required this.characterName,
      required this.characterImg});

  factory Cast.fromJson({required Map<String, dynamic> json}) {
    return Cast(
      name: json["name"] ?? "",
      characterName: json["character_name"] ?? "",
      characterImg: json["url_small_image"] ?? "",
    );
  }

    Map<String, dynamic> toJson() {
    return {
      "name": name,
      "character_name": characterName,
      "url_small_image": characterImg,
    };
  }
}