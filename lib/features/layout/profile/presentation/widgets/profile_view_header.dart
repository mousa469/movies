import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/extensions/routing_extension.dart';
import 'package:movies/core/extensions/space_extension.dart';
import 'package:movies/core/helper%20functions/custom_snake_bar.dart';
import 'package:movies/core/services/local_storage/hive.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/core/widgets/error_widget.dart';
import 'package:movies/features/authentication/presentation/views/login_view.dart';
import 'package:movies/features/layout/profile/presentation/bloc/fetch_list_of_movies/fetch_list_of_movies_cubit.dart';
import 'package:movies/features/layout/profile/presentation/bloc/fetch_number_movies_in_watch_list/fetch_number_movies_in_watch_list_cubit.dart';
import 'package:movies/features/layout/profile/presentation/bloc/log_out_cubit/log_out_cubit.dart';
import 'package:movies/features/layout/profile/presentation/bloc/number_of_history_movies/number_of_history_movies_cubit.dart';
import 'package:movies/features/layout/profile/presentation/views/update_profile_view.dart';

class ProfileViewHeader extends StatefulWidget {
  const ProfileViewHeader({super.key});

  @override
  State<ProfileViewHeader> createState() => _ProfileViewHeaderState();
}

class _ProfileViewHeaderState extends State<ProfileViewHeader> {
  int oldValue = 0;
  @override
  void initState() {
    BlocProvider.of<NumberOfHistoryMoviesCubit>(context)
        .fetchNumberOfMoviesInHistory();
    super.initState();
    BlocProvider.of<FetchNumberMoviesInWatchListCubit>(context)
        .FetchNumberOfWatchListMovies();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.primaryBlackColor,
      child: Column(
        children: [
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  HiveStorage().getString(key: LocalStorage.userName) ?? "",
                  style: AppStyles.textStyle20Bold,
                )
              ],
            ),
          ),
          32.verticalSpace(),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    BlocBuilder<NumberOfHistoryMoviesCubit,
                        NumberOfHistoryMoviesState>(
                      builder: (context, state) {
                        if (state is NumberOfHistoryMoviesSuccess) {
                          return Text(
                            state.numberOfMovies.toString(),
                            style: AppStyles.textStyle36Bold,
                          );
                        } else if (state is NumberOfHistoryMoviesFailure) {
                          return ErrorMessage(errMessage: state.errMessage);
                        } else {
                          return Lottie.asset(Assets.animationsLoadingAnimation,
                              height: 50);
                        }
                      },
                    ),
                    Text(
                      "History",
                      style: AppStyles.textStyle24Bold,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    BlocBuilder<FetchNumberMoviesInWatchListCubit,
                        FetchNumberMoviesInWatchListState>(
                      builder: (context, state) {
                        if (state is FetchNumberMoviesInWatchListSuccess) {
                          return Text(
                            state.numberOfMovies.toString(),
                            style: AppStyles.textStyle36Bold,
                          );
                        } else if (state
                            is FetchNumberMoviesInWatchListFailure) {
                          return ErrorMessage(errMessage: state.errMessage);
                        } else {
                          return Lottie.asset(Assets.animationsLoadingAnimation,
                              height: 50);
                        }
                      },
                    ),
                    Text(
                      "watch List",
                      style: AppStyles.textStyle24Bold,
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.verticalSpace(),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kPrimaryColor,
                ),
                onPressed: () {
                  context.pushNamed(UpdateProfileView.id);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Text(
                    "Edit Profile",
                    style: AppStyles.textStyle20Regular
                        .copyWith(color: AppColors.secondaryBlackColor),
                  ),
                ),
              ),
              12.horizontalSpace(),
              Expanded(
                child: BlocListener<LogOutCubit, LogOutState>(
                  listener: (context, state) {
                    if (state is LogOutSuccess) {
                      showAwesomeSnackBar(
                        context: context,
                        title: "Success",
                        message: state.successMessage,
                        contentType: ContentType.success,
                      );
                      context.pushAndRemoveUntil(LoginView.id);
                    } else if (state is LogOutFailure) {
                      showAwesomeSnackBar(
                        context: context,
                        title: "Opps",
                        message: state.errMessage,
                        contentType: ContentType.failure,
                      );
                    }
                  },
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redColor,
                    ),
                    onPressed: () {
                      BlocProvider.of<LogOutCubit>(context).logOut();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "Exit",
                            style: AppStyles.textStyle20Regular
                                .copyWith(color: AppColors.whiteColor),
                          ),
                        ),
                        Icon(
                          Icons.logout,
                          color: AppColors.whiteColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          32.verticalSpace(),
          DefaultTabController(
            length: 2,
            child: TabBar(
              onTap: (value) {
                if (oldValue != value) {
                  BlocProvider.of<FetchListOfMoviesyCubit>(context).index =
                      value;
                  BlocProvider.of<FetchListOfMoviesyCubit>(context)
                      .fetchListOfMoviesInHistory();
                }
                oldValue = value;
              },
              indicatorColor: AppColors.kPrimaryColor,
              tabs: [
                Column(
                  children: [
                    Icon(
                      size: 35,
                      Icons.list,
                      color: AppColors.kPrimaryColor,
                    ),
                    Text(
                      "Watch List",
                      style: AppStyles.textStyle20Regular
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      size: 35,
                      Icons.folder,
                      color: AppColors.kPrimaryColor,
                    ),
                    Text(
                      "History",
                      style: AppStyles.textStyle20Regular
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
    //  Row(
    //         children: [
    //           Expanded(
    //             child: Column(
    //               children: [
    //                 Icon(
    //                   size: 35,
    //                   Icons.list,
    //                   color: AppColors.kPrimaryColor,
    //                 ),
    //                 Text(
    //                   "Watch List",
    //                   style: AppStyles.textStyle20Regular
    //                       .copyWith(color: AppColors.whiteColor),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Expanded(
    //             child: Column(
    //               children: [
    //                 Icon(
    //                   size: 35,
    //                   Icons.folder,
    //                   color: AppColors.kPrimaryColor,
    //                 ),
    //                 Text(
    //                   "History",
    //                   style: AppStyles.textStyle20Regular
    //                       .copyWith(color: AppColors.whiteColor),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),