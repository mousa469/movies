import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/layout/browse/presentation/views/browse_view.dart';
import 'package:movies/features/layout/home/presentation/views/home_view.dart';
import 'package:movies/features/layout/profile/presentation/views/profile_View.dart';
import 'package:movies/features/layout/search/presentation/views/search_view.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});
  static const String id = "layout";

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int currentIndex = 0;
  List<Widget> views = [HomeView(), SearchView(), BrowseView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.primaryBlackColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: AppColors.kPrimaryColor,
            unselectedItemColor: AppColors.whiteColor,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.house,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.magnifyingGlassMinus,
                  ),
                  label: "Search"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.explore,
                  ),
                  label: "Browse"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: "Profile"),
            ],
          ),
        ),
      ),
      body: views[currentIndex],
    );
  }
}
