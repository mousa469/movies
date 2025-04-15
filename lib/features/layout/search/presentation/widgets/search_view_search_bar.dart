import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/widgets/custom_text_form_field.dart';
import 'package:movies/features/layout/search/presentation/bloc/search_movie/search_movie_cubit.dart';

class SearchViewSearchBar extends StatefulWidget {
  const SearchViewSearchBar({super.key});

  @override
  State<SearchViewSearchBar> createState() => _SearchViewSearchBarState();
}

class _SearchViewSearchBarState extends State<SearchViewSearchBar> {
  TextEditingController searchController = TextEditingController();
  Timer? debounce;

  void onSearchChanged(String? query) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(seconds: 2), () {
      BlocProvider.of<SearchMovieCubit>(context).search(query: query!);
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomTextField(
          onChanged: onSearchChanged,
          controller: searchController,
          hint: "Search Movie",
          prefixIcon: Icon(Icons.search),
        )
      ],
    ));
  }
}
