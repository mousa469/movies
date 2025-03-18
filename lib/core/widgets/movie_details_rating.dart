import 'package:flutter/material.dart';

class MovieDetailsRating extends StatelessWidget {
  const MovieDetailsRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: .1),
          borderRadius: BorderRadius.all(Radius.circular(16))),
      width: double.infinity,
      child: Row(
        children: [
          Text(
            "7.4/10",
            style: TextStyle(color: Colors.black),
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          )
        ],
      ),
    );
  }
}
