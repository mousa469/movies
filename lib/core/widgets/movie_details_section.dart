import 'package:flutter/material.dart';
import 'package:movies/core/extensions/media_query_extension.dart';
import 'package:movies/core/extensions/space_extension.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsSection extends StatelessWidget {
  const MovieDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: context.screenWidth(.33),
          child: Text(
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            "Aurora (2025)",
            style: AppStyles.textStyle24Bold.copyWith(color: Colors.black),
          ),
        ),
        10.verticalSpace(),
        SizedBox(
          height: 100,
          width: 100,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: 2,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      "Drama",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Text(
          "Language : en",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        12.verticalSpace(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kPrimaryColor),
          onPressed: () {
            void launchURL() async {
              final Uri url = Uri.parse(
                  'https://yts.mx/torrent/download/C42487F27C20D9D178EBA37F409FAE51670E92D6');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw 'Could not launch $url';
              }
            }
          },
          child: Row(
            children: [
              Text(
                "Watch Trailer ",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
