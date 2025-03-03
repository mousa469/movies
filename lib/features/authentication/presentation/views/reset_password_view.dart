import 'package:flutter/material.dart';
import 'package:movies/features/authentication/presentation/views/widgets/authCustomAppBar.dart';
import 'package:movies/features/authentication/presentation/views/widgets/reset_password_view_body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});
  static const String id = "/resetPasswordView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthCustomAppBar(title: "Forget Password "),
      body: ResetPasswordViewBody(),
    );
  }
}
