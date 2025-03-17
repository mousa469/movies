import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/extensions/media_query_extension.dart';
import 'package:movies/core/extensions/padding_extension.dart';
import 'package:movies/core/helper%20functions/custom_snake_bar.dart';
import 'package:movies/core/widgets/error_widget.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/presentation/bloc/watch_now_cubit/watch_now_cubit.dart';
import 'package:movies/features/layout/home/presentation/widgets/movies_item.dart';
import 'package:movies/generated/l10n.dart';

class WatchNowListViewBuilder extends StatefulWidget {
  const WatchNowListViewBuilder({super.key});

  @override
  State<WatchNowListViewBuilder> createState() =>
      _WatchNowListViewBuilderState();
}

class _WatchNowListViewBuilderState extends State<WatchNowListViewBuilder> {
  List<MovieEntity>? movies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<WatchNowCubit>(context).fetchWatchNowMovies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WatchNowCubit, WatchNowState>(
      listener: (context, state) {
        if (state is WatchNowFailure) {
          showAwesomeSnackBar(
              context: context,
              title: S.of(context).Opps,
              message: state.errMessage,
              contentType: ContentType.failure);
        }
      },
      builder: (context, state) {
        if (state is WatchNowSuccess) {
          return SizedBox(
            height: context.screenHeight(.3),
            child: ListView.builder(
              itemCount: state.movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return MoviesItem(
                  height: context.screenHeight(0.236),
                  width: context.screenWidth(0.3395),
                  entity: state.movies[index],
                ).customePadding(left: 16);
              },
            ),
          );
        } else if (state is WatchNowFailure) {
          return ErrorMessage(errMessage: state.errMessage,);
        } else {
          return Lottie.asset(Assets.animationsLoadingAnimation);
        }
      },
    );
  }
}
