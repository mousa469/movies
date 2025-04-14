import 'package:flutter/material.dart';
import 'package:movies/features/layout/profile/presentation/widgets/update_profile_view_body.dart';

class UpdateProfileView extends StatelessWidget {
  const UpdateProfileView({super.key});
  static const String id = "updateProfileView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: UpdateProfileViewBody() ,
    );
  }
}
