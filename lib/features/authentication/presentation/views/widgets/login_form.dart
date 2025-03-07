import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/extensions/routing_extension.dart';
import 'package:movies/core/extensions/space_extension.dart';
import 'package:movies/core/helper%20functions/custom_easy_loading.dart';
import 'package:movies/core/helper%20functions/custom_snake_bar.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/core/widgets/custom_button.dart';
import 'package:movies/core/widgets/custom_text_form_field.dart';
import 'package:movies/features/authentication/data/models/sign_in_user_request.dart';
import 'package:movies/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:movies/features/authentication/presentation/views/register.dart';
import 'package:movies/features/authentication/presentation/views/reset_password_view.dart';
import 'package:movies/features/authentication/presentation/views/widgets/custom_text_button.dart';
import 'package:movies/features/layout/presentation/views/layout_view.dart';
import 'package:movies/generated/l10n.dart';

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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          CustomEasyLoading.showLoading();
        }

        if (state is AuthSuccess) {
          CustomEasyLoading.hideLoading();
          showAwesomeSnackBar(
              context: context,
              title: S.of(context).congratualtions,
              message: S.of(context).sign_in_successfully,
              contentType: ContentType.success);
          context.pushAndRemoveUntil(LayoutView.id,
              arguments: state.userCredential);
        }

        if (state is AuthFailure) {
          CustomEasyLoading.hideLoading();
          showAwesomeSnackBar(
              context: context,
              title: S.of(context).Opps,
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
                  return S.of(context).email_address_is_required;
                }
                return null;
              },
              controller: emailController,
              prefixIcon: Icon(
                Icons.email,
                color: AppColors.whiteColor,
              ),
              hint: S.of(context).email,
              hintColor: AppColors.whiteColor,
            ),
            20.verticalSpace(),
            CustomTextField(
              onValidate: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).password_is_required;
                }
                return null;
              },
              controller: passwordController,
              prefixIcon: Icon(
                Icons.lock,
                color: AppColors.whiteColor,
              ),
              hint: S.of(context).password,
              hintColor: AppColors.whiteColor,
              isPassword: true,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CustomTextButton(
                text: S.of(context).forget_password_question,
                onPress: () {
                  context.pushNamed(ResetPasswordView.id);
                },
              ),
            ),
            16.verticalSpace(),
            CustomElevatedButton(
              color: AppColors.kPrimaryColor,
              child: Text(
                S.of(context).login,
                style: AppStyles.textStyle16Regular
                    .copyWith(color: AppColors.secondaryBlackColor),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<AuthCubit>().signInUser(SignInUserRequest(
                      email: emailController.text,
                      password: passwordController.text));
                }
              },
            ),
            20.verticalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).dont_have_account_question,
                  style: AppStyles.textStyle16Regular.copyWith(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomTextButton(
                  text: S.of(context).create_account,
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
                  S.of(context).or,
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
                    S.of(context).login_with_google,
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
