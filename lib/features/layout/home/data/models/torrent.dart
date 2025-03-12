class Torrent {
  final String url;
  final String quality;
  final String type;
  final String videoCodec;
  final int sizeBytes;

  Torrent({
    required this.url,
    required this.quality,
    required this.type,
    required this.videoCodec,
    required this.sizeBytes,
  });

  factory Torrent.fromJson(Map<String, dynamic> json) {
    return Torrent(
      url: json["url"],
      quality: json["quality"],
      type: json["type"],
      videoCodec: json["video_codec"],
      sizeBytes: json["size_bytes"],
    );
  }

    Map<String, dynamic> toJson() {
    return {
      "url": url,
      "quality": quality,
      "type": type,
      "video_codec": videoCodec,
      "size_bytes": sizeBytes,
    };
  }

}