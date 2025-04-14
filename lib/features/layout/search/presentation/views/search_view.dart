import 'package:flutter/material.dart';
import 'package:movies/features/layout/search/presentation/widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  static const String id = "SearchView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchViewBody(),
    );
  }
}
