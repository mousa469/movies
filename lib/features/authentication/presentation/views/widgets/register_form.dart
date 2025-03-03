import 'package:flutter/material.dart';
import 'package:movies/core/extensions/routing_extension.dart';
import 'package:movies/core/extensions/space_extension.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/core/widgets/custom_button.dart';
import 'package:movies/core/widgets/custom_text_form_field.dart';
import 'package:movies/generated/l10n.dart';

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
    return Form(
      key: formKey,
      child: Column(
        children: [
          30.verticalSpace(),
          CustomTextField(
            onValidate: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).name_is_required;
              }
              return null;
            },
            controller: nameController,
            prefixIcon: Icon(
              Icons.person,
              color: AppColors.whiteColor,
            ),
            hint: S.of(context).name,
            hintColor: AppColors.whiteColor,
          ),
          20.verticalSpace(),
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
          20.verticalSpace(),

          CustomTextField(
            onValidate: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).confirm_password;
              }
              return null;
            },
            controller: rePasswordController,
            prefixIcon: Icon(
              Icons.lock,
              color: AppColors.whiteColor,
            ),
            hint: S.of(context).password,
            hintColor: AppColors.whiteColor,
            isPassword: true,
          ),
          20.verticalSpace(),

          CustomTextField(
            onValidate: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).phone_number_is_required;
              }
              return null;
            },
            controller: phoneController,
            prefixIcon: Icon(
              Icons.lock,
              color: AppColors.whiteColor,
            ),
            hint: S.of(context).phone_number,
            hintColor: AppColors.whiteColor,
          ),
          // 5.verticalSpace(),
          16.verticalSpace(),
          CustomElevatedButton(
            color: AppColors.kPrimaryColor,
            child: Text(
              S.of(context).create_account,
              style: AppStyles.textStyle20Regular
                  .copyWith(color: AppColors.secondaryBlackColor),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {}
            },
          ),

          20.verticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).already_have_account_question,
                style: AppStyles.textStyle16Regular
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: Text(
                  S.of(context).login,
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
    );
  }
}
