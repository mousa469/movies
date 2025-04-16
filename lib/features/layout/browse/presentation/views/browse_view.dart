import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/extensions/padding_extension.dart';
import 'package:movies/core/services/get_it_services.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/features/layout/browse/domain/usecases/browse_item_by_category_use_case.dart';
import 'package:movies/features/layout/browse/presentation/bloc/browse_movies_by_category/browse_movies_by_category_cubit.dart';
import 'package:movies/features/layout/browse/presentation/widgets/browse_movie_category_item.dart';
import 'package:movies/features/layout/browse/presentation/widgets/movies_category_grid_view_builder.dart';
import 'package:movies/features/layout/browse/presentation/widgets/movies_category_list_view_builder.dart';

class BrowseView extends StatelessWidget {
  const BrowseView({super.key});

  static const String id = "BrowseView";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BrowseMoviesByCategoryCubit(
          browseItemByCategoryUseCase: getIt<BrowseMovieByCategoryUseCase>()),
      child: Column(
        children: [
          MoviesCategoryListViewBuilder(),
          SizedBox(
            height: 16,
          ),
          MoviesCategoryGridViewBuilder()
        ],
      ),
    ).customePadding(left: 16);
  }
}
