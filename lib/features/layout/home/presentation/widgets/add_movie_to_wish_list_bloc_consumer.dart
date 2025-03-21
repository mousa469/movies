import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/helper%20functions/custom_snake_bar.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/presentation/bloc/add_movie_to_wish_list_cubit/add_movie_to_wishlist_cubit.dart';
import 'package:movies/generated/l10n.dart';

class AddMovieToWishListBlocConsumer extends StatelessWidget {
  const AddMovieToWishListBlocConsumer({super.key, required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddMovieToWishlistCubit, AddMovieToWishlistState>(
      listener: (context, state) {
        if (state is AddMovieToWishlistFailure) {
          showAwesomeSnackBar(
              context: context,
              title: S.of(context).Opps,
              message: state.errMessage,
              contentType: ContentType.failure);
        }
        if (state is AddMovieToWishlistSuccess) {
          showAwesomeSnackBar(
              context: context,
              title: S.of(context).congratualtions,
              message: S.of(context).movieAddedToWishListSuccessfully,
              contentType: ContentType.success);
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              context
                  .read<AddMovieToWishlistCubit>()
                  .addMovieToWishList(movie: movie);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kPrimaryColor,
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
            child: state is AddMovieToWishlistLoading
                ? Lottie.asset(Assets.animationsLoadingAnimation, width: 30)
                : Text(
                    'Add to wish list ',
                    style: AppStyles.textStyle20Bold
                        .copyWith(color: AppColors.secondaryBlackColor),
                  ),
          ),
        );
      },
    );
  }
}
