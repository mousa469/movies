import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Test extends StatelessWidget {
  static const String id = "test"; // Added static ID for navigation

  final Map<String, dynamic> movie = {
    "title": "Curse of the Seven Oceans",
    "year": 2024,
    "rating": 5.7,
    "runtime": 94,
    "genres": ["Horror", "Thriller"],
    "yt_trailer_code": "1Wz4r3758CY",
    "large_cover_image": "https://yts.mx/assets/images/movies/curse_of_the_seven_oceans_2024/large-cover.jpg",
    "torrents": [
      {
        "quality": "720p",
        "size": "865.45 MB",
      },
      {
        "quality": "1080p",
        "size": "1.74 GB",
      }
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie["title"]),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.black,
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: movie["large_cover_image"],
                      height: 250,
                      width: 170,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${movie["title"]} (${movie["year"]})",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      SizedBox(width: 5),
                      Text("${movie["rating"]}/10", style: TextStyle(color: Colors.white)),
                      Spacer(),
                      Text("${movie["runtime"]} min", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: movie["genres"].map<Widget>((genre) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(genre, style: TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final url = "https://www.youtube.com/watch?v=${movie["yt_trailer_code"]}";
                        print("Opening trailer: $url");
                      },
                      icon: Icon(Icons.play_arrow),
                      label: Text("Watch Trailer"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Available Downloads:", style: TextStyle(color: Colors.white, fontSize: 16)),
                  Column(
                    children: movie["torrents"].map<Widget>((torrent) {
                      return ListTile(
                        leading: Icon(Icons.download, color: Colors.white),
                        title: Text("${torrent["quality"]} - ${torrent["size"]}", style: TextStyle(color: Colors.white)),
                        onTap: () {
                          print("Downloading: ${torrent["quality"]}");
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}