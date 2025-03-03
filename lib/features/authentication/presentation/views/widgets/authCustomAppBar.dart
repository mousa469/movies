import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_styles.dart';

class AuthCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuthCustomAppBar({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      title: Text(
        title,
        style: AppStyles.textStyle16Regular,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
