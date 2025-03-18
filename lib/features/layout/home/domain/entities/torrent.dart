class Torrent {
  final String url;
  final String quality;
  final String size;
  final String videoCodec;
  final String audioChannels;

  Torrent({
    required this.url,
    required this.quality,
    required this.size,
    required this.videoCodec,
    required this.audioChannels,
  });

  factory Torrent.fromJson(Map<String, dynamic> json) {
    return Torrent(
      url: json['url'],
      quality: json['quality'] as String,
      size: json['size'] as String,
      videoCodec: json['video_codec'] as String,
      audioChannels: json['audio_channels'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'quality': quality,
      'size': size,
      'video_codec': videoCodec,
      'audio_channels': audioChannels,
    };
  }
}
