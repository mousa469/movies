
import 'package:flutter/material.dart';
import 'package:movies/core/extensions/routing_extension.dart';
import 'package:movies/core/extensions/space_extension.dart';
import 'package:movies/core/theme/app_styles.dart';

class AuthenticationCustomAppBar extends StatelessWidget {
  const AuthenticationCustomAppBar({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              context.pop;
            },
            icon: Icon(Icons.arrow_back),
          ),
          100.horizontalSpace(),
          Text(
            textAlign: TextAlign.center,
            text,
            style: AppStyles.textStyle16Regular,
          ),
        ],
      ),
    );
  }
}
