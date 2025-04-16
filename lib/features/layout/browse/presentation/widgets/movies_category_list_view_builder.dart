import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/extensions/media_query_extension.dart';
import 'package:movies/core/services/get_it_services.dart';
import 'package:movies/features/layout/browse/domain/usecases/browse_item_by_category_use_case.dart';
import 'package:movies/features/layout/browse/presentation/bloc/browse_movies_by_category/browse_movies_by_category_cubit.dart';
import 'package:movies/features/layout/browse/presentation/widgets/browse_movie_category_item.dart';

class MoviesCategoryListViewBuilder extends StatefulWidget {
  const MoviesCategoryListViewBuilder({super.key});

  @override
  State<MoviesCategoryListViewBuilder> createState() =>
      _MoviesCategoryListViewBuilderState();
}

class _MoviesCategoryListViewBuilderState
    extends State<MoviesCategoryListViewBuilder> {
  List<String> categories = [
    "Action",
    "Adventure",
    "Animation",
    "Comedy",
    "Crime",
    "Documentary",
    "Drama",
    "Family",
    "Fantasy",
    "History",
    "Horror",
    "Mystery",
    "Romance",
    "Science Fiction",
    "Thriller",
    "War",
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    BlocProvider.of<BrowseMoviesByCategoryCubit>(context)
        .getMoviesByCategory(category: categories[0]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: context.screenHeight(0.08),
        child: ListView.builder(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    BlocProvider.of<BrowseMoviesByCategoryCubit>(context)
                        .getMoviesByCategory(category: categories[index]);
                  });
                },
                child: BrowseMovieCategoryItem(
                  isSelected: selectedIndex == index ? true : false,
                  name: categories[index],
                ),
              );
            }),
      ),
    );
  }
}
