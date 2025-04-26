import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/constants.dart';
import 'package:movies/core/extensions/routing_extension.dart';
import 'package:movies/core/extensions/space_extension.dart';
import 'package:movies/core/helper%20functions/custom_easy_loading.dart';
import 'package:movies/core/helper%20functions/custom_snake_bar.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/core/widgets/custom_button.dart';
import 'package:movies/core/widgets/custom_text_form_field.dart';
import 'package:movies/features/authentication/presentation/sign_up_cubit/sign_up_cubit.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          CustomEasyLoading.showLoading();
        }

        if (state is SignUpSuccess) {
          CustomEasyLoading.hideLoading();
          showAwesomeSnackBar(
            contentType: ContentType.success,
            context: context,
            message: registeredSuccessfully,
            title: congratualtions,
          );
          context.pop();
        }

        if (state is SignUpFailure) {
          CustomEasyLoading.hideLoading();
          showAwesomeSnackBar(
            contentType: ContentType.failure,
            context: context,
            message: state.errMessage,
            title:opps,
          );
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
                  return nameIsRequired;
                }
                return null;
              },
              controller: nameController,
              prefixIcon: Icon(
                Icons.person,
                color: AppColors.whiteColor,
              ),
              hint: name,
              hintColor: AppColors.whiteColor,
            ),
            20.verticalSpace(),
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
            20.verticalSpace(),

            CustomTextField(
              onValidate: (value) {
                if (value == null || value.isEmpty) {
                  return confirmPassword;
                }
                return null;
              },
              controller: rePasswordController,
              prefixIcon: Icon(
                Icons.lock,
                color: AppColors.whiteColor,
              ),
              hint: password,
              hintColor: AppColors.whiteColor,
              isPassword: true,
            ),
            20.verticalSpace(),

            CustomTextField(
              onValidate: (value) {
                if (value == null || value.isEmpty) {
                  return phoneNumberIsRequired;
                }
                return null;
              },
              controller: phoneController,
              prefixIcon: Icon(
                Icons.lock,
                color: AppColors.whiteColor,
              ),
              hint: phoneNumber,
              hintColor: AppColors.whiteColor,
            ),
            // 5.verticalSpace(),
            16.verticalSpace(),
            CustomElevatedButton(
              color: AppColors.kPrimaryColor,
              child: Text(
                createAccount,
                style: AppStyles.textStyle20Regular
                    .copyWith(color: AppColors.secondaryBlackColor),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (passwordController.text == rePasswordController.text) {
                    context.read<SignUpCubit>().createNewUser(
                        phone: phoneController.text,
                        name: nameController.text,
                        password: passwordController.text,
                        email: emailController.text);
                  } else {
                    showAwesomeSnackBar(
                        context: context,
                        title:warning,
                        message: passwordMismatch,
                        contentType: ContentType.warning);
                  }
                }
              },
            ),

            20.verticalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  alreadyHaveAccountQuestion,
                  style: AppStyles.textStyle16Regular
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Text(
                    login,
                    style: AppStyles.textStyle16Regular.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.kPrimaryColor,
                        color: AppColors.kPrimaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
