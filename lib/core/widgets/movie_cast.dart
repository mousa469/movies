import 'package:flutter/material.dart';
import 'package:movies/core/extensions/padding_extension.dart';
import 'package:movies/core/widgets/cast_card.dart';
import 'package:movies/features/layout/home/domain/entities/cast.dart';

class MovieCast extends StatelessWidget {
  const MovieCast({super.key, required this.cast});

  final List<Cast> cast;
  @override
  Widget build(BuildContext context) {
    return cast.isNotEmpty
        ? SliverList.builder(
            itemCount: cast.length,
            itemBuilder: (context, index) => CastCard(
              cast: cast[index],
            ),
          )
        : SliverToBoxAdapter(
            child: Text("No cast available").horizontalPadding(value: 16),
          );
  }
}
