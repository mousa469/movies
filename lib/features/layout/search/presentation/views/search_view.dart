import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/extensions/padding_extension.dart';
import 'package:movies/core/services/get_it_services.dart';
import 'package:movies/features/layout/home/presentation/widgets/movies_item.dart';
import 'package:movies/features/layout/search/domain/usecases/search_movies_use_case.dart';
import 'package:movies/features/layout/search/presentation/bloc/search_movie/search_movie_cubit.dart';
import 'package:movies/features/layout/search/presentation/widgets/search_view_search_bar.dart';
import 'package:movies/features/layout/search/presentation/widgets/searched_movies_item_grid_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});
  static const String id = "SearchView";

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchMovieCubit(searchMoviesUseCase: getIt<SearchMoviesUseCase>()),
      child: Column(children: [
        const SearchViewSearchBar(),
        SearchedMoviesItemGridView()
      ]),
    ).symmetricPadding(horizontalValue: 16, verticalValue: 8);
  }
}
