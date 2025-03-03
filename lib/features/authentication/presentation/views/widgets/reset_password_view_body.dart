import 'package:flutter/material.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/extensions/media_query_extension.dart';
import 'package:movies/core/extensions/space_extension.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/core/widgets/custom_button.dart';
import 'package:movies/core/widgets/custom_text_form_field.dart';
import 'package:movies/generated/l10n.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Image.asset(
            Assets.imagesForgotPassword,
            width: context.screenWidth(0.9),
          ),
          30.verticalSpace(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    onValidate: (value) {
                      if (value == value || value!.isEmpty) {
                        return S.of(context).email_address_is_required;
                      }
                      return null;
                    },
                    hint: "Email",
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  30.verticalSpace(),
                  CustomElevatedButton(
                      color: AppColors.kPrimaryColor,
                      child: Text(
                        S.of(context).verify_email,
                        style: AppStyles.textStyle20Regular
                            .copyWith(color: AppColors.secondaryBlackColor),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {}
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
