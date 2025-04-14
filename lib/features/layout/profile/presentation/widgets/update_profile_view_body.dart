import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/extensions/padding_extension.dart';
import 'package:movies/core/extensions/space_extension.dart';
import 'package:movies/core/helper%20functions/custom_easy_loading.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/core/widgets/custom_button.dart';
import 'package:movies/core/widgets/custom_text_form_field.dart';
import 'package:movies/features/layout/profile/presentation/bloc/fetch_user_data/fetch_user_data_cubit.dart';
import 'package:movies/features/layout/profile/presentation/bloc/update_user_data/update_user_data_cubit.dart';
import 'package:movies/features/layout/profile/presentation/widgets/user_item_information.dart';

class UpdateProfileViewBody extends StatefulWidget {
  const UpdateProfileViewBody({super.key});

  @override
  State<UpdateProfileViewBody> createState() => _UpdateProfileViewBodyState();
}

class _UpdateProfileViewBodyState extends State<UpdateProfileViewBody> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<FetchUserDataCubit>(context).fetchUserData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchUserDataCubit, FetchUserDataState>(
      builder: (context, state) {
        if (state is FetchUserDataSuccess) {
          return Column(
            children: [
              UserItemInformation(
                icon: Icons.person,
                info: state.user.name,
              ),
              16.verticalSpace(),
              UserItemInformation(
                icon: Icons.phone,
                info: state.user.phone,
              ),
              Spacer(),
              8.verticalSpace(),
              CustomElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return BlocListener<UpdateUserDataCubit,
                          UpdateUserDataState>(
                        listener: (context, state) {
                          if (state is UpdateUserDataSuccess) {
                            CustomEasyLoading.hideLoading();
                            BlocProvider.of<FetchUserDataCubit>(context)
                                .fetchUserData();
                            CustomEasyLoading.showSuccess(
                                "User data updated successfully");
                          } else if (state is UpdateUserDataFailure) {
                            CustomEasyLoading.hideLoading();
                            CustomEasyLoading.showError(state.errMessage);
                          } else {
                            CustomEasyLoading.showLoading();
                          }
                        },
                        child: IntrinsicHeight(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                CustomTextField(
                                  controller: nameController,
                                  hint: "New Name",
                                ),
                                16.verticalSpace(),
                                CustomTextField(
                                  controller: phoneController,
                                  hint: "New Phone",
                                ),
                                16.verticalSpace(),
                                CustomElevatedButton(
                                  color: AppColors.kPrimaryColor,
                                  child: Text(
                                    "Update",
                                    style: AppStyles.textStyle20Regular
                                        .copyWith(
                                            color:
                                                AppColors.secondaryBlackColor),
                                  ),
                                  onPressed: () {
                                    if (nameController.text.isEmpty &&
                                        phoneController.text.isNotEmpty) {
                                      BlocProvider.of<UpdateUserDataCubit>(
                                              context)
                                          .updateUserData(
                                              userName: state.user.name,
                                              userPhone: phoneController.text);
                                    } else if (phoneController.text.isEmpty &&
                                        nameController.text.isNotEmpty) {
                                      BlocProvider.of<UpdateUserDataCubit>(
                                              context)
                                          .updateUserData(
                                              userName: nameController.text,
                                              userPhone: state.user.phone);
                                    } else if (nameController.text.isNotEmpty &&
                                        phoneController.text.isNotEmpty) {
                                      BlocProvider.of<UpdateUserDataCubit>(
                                              context)
                                          .updateUserData(
                                              userName: nameController.text,
                                              userPhone: phoneController.text);
                                    } else {
                                      CustomEasyLoading.showError(
                                          "At least one of the two fields are required");
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                color: AppColors.kPrimaryColor,
                child: Text(
                  "Update Data",
                  style: AppStyles.textStyle20Regular
                      .copyWith(color: AppColors.secondaryBlackColor),
                ),
              ),
              8.verticalSpace(),
            ],
          );
        } else if (state is FetchUserDataFailure) {
          return ErrorWidget(state.errMessage);
        } else {
          return Lottie.asset(Assets.animationsLoadingAnimation);
        }
      },
    ).horizontalPadding(value: 16);
  }
}
