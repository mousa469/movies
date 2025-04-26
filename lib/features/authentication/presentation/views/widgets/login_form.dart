import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/constants.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/extensions/routing_extension.dart';
import 'package:movies/core/extensions/space_extension.dart';
import 'package:movies/core/helper%20functions/custom_easy_loading.dart';
import 'package:movies/core/helper%20functions/custom_snake_bar.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/core/widgets/custom_button.dart';
import 'package:movies/core/widgets/custom_text_form_field.dart';
import 'package:movies/features/authentication/presentation/sign_in_cubit/sign_in_cubit.dart';
import 'package:movies/features/authentication/presentation/views/register.dart';
import 'package:movies/features/authentication/presentation/views/reset_password_view.dart';
import 'package:movies/features/authentication/presentation/views/widgets/custom_text_button.dart';
import 'package:movies/features/layout/presentation/views/layout_view.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInLoading) {
          CustomEasyLoading.showLoading();
        }

        if (state is SignInSuccess) {
          CustomEasyLoading.hideLoading();
          showAwesomeSnackBar(
              context: context,
              title: congratualtions,
              message: signInSuccessfully,
              contentType: ContentType.success);
          context.pushAndRemoveUntil(
            LayoutView.id,
          );
        }

        if (state is SignInFailure) {
          CustomEasyLoading.hideLoading();
          showAwesomeSnackBar(
              context: context,
              title: opps,
              message: state.errMessage,
              contentType: ContentType.failure);
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          children: [
            30.verticalSpace(),
            CustomTextField(
              onValidate: (value) {
                if (value == null || value.isEmpty) {
                  return emailAddressIsRequired;
                }
                return null;
              },
              controller: emailController,
              prefixIcon: Icon(
                Icons.email,
                color: AppColors.whiteColor,
              ),
              hint: email,
              hintColor: AppColors.whiteColor,
            ),
            20.verticalSpace(),
            CustomTextField(
              onValidate: (value) {
                if (value == null || value.isEmpty) {
                  return passwordIsRequired;
                }
                return null;
              },
              controller: passwordController,
              prefixIcon: Icon(
                Icons.lock,
                color: AppColors.whiteColor,
              ),
              hint: password,
              hintColor: AppColors.whiteColor,
              isPassword: true,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CustomTextButton(
                text: forgetPasswordQuestion,
                onPress: () {
                  context.pushNamed(ResetPasswordView.id);
                },
              ),
            ),
            16.verticalSpace(),
            CustomElevatedButton(
              color: AppColors.kPrimaryColor,
              child: Text(
                login,
                style: AppStyles.textStyle16Regular
                    .copyWith(color: AppColors.secondaryBlackColor),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<SignInCubit>().signInUser(
                      email: emailController.text,
                      password: passwordController.text);
                }
              },
            ),
            20.verticalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dontHaveAccountQuestion,
                  style: AppStyles.textStyle16Regular.copyWith(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomTextButton(
                  text: createAccount,
                  onPress: () {
                    context.pushNamed(RegisterView.id);
                  },
                ),
              ],
            ),
            16.verticalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    endIndent: 20,
                    indent: 20,
                  ),
                ),
                Text(
                  or,
                  style: AppStyles.textStyle16Regular
                      .copyWith(color: AppColors.kPrimaryColor),
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    endIndent: 20,
                    indent: 20,
                  ),
                ),
              ],
            ),
            16.verticalSpace(),

            CustomElevatedButton(
              onPressed: () {
                context.read<SignInCubit>().signInWithGoogle();
              },
              color: AppColors.kPrimaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.iconsGoogleIconOrg,
                    width: 23,
                    height: 30,
                  ),
                  10.horizontalSpace(),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    loginWithGoogle,
                    style: AppStyles.textStyle20RegularAuto.copyWith(
                      color: AppColors.secondaryBlackColor,
                    ),
                  ),
                ],
              ),
            ),
            8.verticalSpace(),

            CustomElevatedButton(
              onPressed: () {
                context.read<SignInCubit>().signInWithFacebook();
              },
              color: AppColors.kPrimaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.iconsFacebookAppSymbol,
                    width: 23,
                    height: 30,
                  ),
                  10.horizontalSpace(),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    loginWithFacebook,
                    style: AppStyles.textStyle20RegularAuto.copyWith(
                      color: AppColors.secondaryBlackColor,
                    ),
                  ),
                ],
              ),
            )
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: AppColors.whiteColor,
            //     elevation: 0,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(16),
            //       side: BorderSide(color: AppColors.kPrimaryColor),
            //     ),
            //   ),
            //   onPressed: () {},
            //   child: Padding(
            //     padding: const EdgeInsets.all(5.0),
            //     child: Padding(
            //       padding: EdgeInsets.all(2),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Image.asset(
            //             Assets.iconsGoogleIcon,
            //             width: 23,
            //             height: 30,
            //           ),
            //           10.horizontalSpace(),
            //           Text(
            //             maxLines: 1,
            //             overflow: TextOverflow.ellipsis,
            //             S.of(context).login_with_google,
            //             style: AppStyles.textStyle20RegularAuto
            //                 .copyWith(color: AppColors.kPrimaryColor),
            //           ),
            //           10.verticalSpace(),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
