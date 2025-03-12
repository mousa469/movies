import 'package:flutter/material.dart';
import 'package:movies/core/extensions/padding_extension.dart';
import 'package:movies/core/extensions/space_extension.dart';

class AvailableMoviesRatingItem extends StatelessWidget {
  const AvailableMoviesRatingItem({super.key, required this.rate});

  final num rate;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          height: 30,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black.withValues(alpha: .6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(rate.toString()),
              4.horizontalSpace(),
              Icon(
                Icons.star,
                color: Colors.amberAccent,
                size: 18,
              )
            ],
          ),
        ),
      ),
    ).symmetricPadding(horizontalValue: 16, verticalValue: 8);
  }
}
