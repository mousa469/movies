import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/constants.dart';
import 'package:movies/core/helper%20functions/custom_snake_bar.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/core/widgets/custom_button.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/presentation/bloc/add_movie_to_wish_list_cubit/add_movie_to_wishlist_cubit.dart';

class AddMovieToWishListBlocListener extends StatelessWidget {
  const AddMovieToWishListBlocListener({super.key, required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddMovieToWishlistCubit, AddMovieToWishlistState>(
      listener: (context, state) {
        if (state is AddMovieToWishlistFailure) {
          showAwesomeSnackBar(
              context: context,
              title: opps,
              message: state.errMessage,
              contentType: ContentType.failure);
        }
        if (state is AddMovieToWishlistSuccess) {
          showAwesomeSnackBar(
              context: context,
              title: congratualtions,
              message: movieAddedToWishListSuccessfully,
              contentType: ContentType.success);
        }
      },
      child: CustomElevatedButton(
        onPressed: () {
          BlocProvider.of<AddMovieToWishlistCubit>(context)
              .addMovieToWishList(movie: movie);
        },
        color: AppColors.redColor,
        child: Text(
          "Add to WishList",
          style:
              AppStyles.textStyle20Bold.copyWith(color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
