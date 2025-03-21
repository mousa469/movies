import 'package:flutter/material.dart';
import 'package:movies/core/extensions/media_query_extension.dart';
import 'package:movies/core/extensions/space_extension.dart';
import 'package:movies/core/widgets/custom_text_form_field.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/presentation/widgets/movies_item.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomTextField(
                hint: "Search",
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 16,
              ),
            ),
            SliverGrid.builder(
              itemCount: 8,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 25,
              ),
              itemBuilder: (context, index) {
                return MoviesItem(
                    entity: MovieEntity(
                      youtubeTrailerCode: "xyz123",
                      year: 2023,
                      url: "https://example.com",
                      runTime: 120,
                      id: 1,
                      poster:
                          "https://yts.mx/assets/images/movies/the_heat_a_kitchen_2018/medium-cover.jpg",
                      rating: 8.5,
                      genres: ["Action", "Thriller"],
                      titleLong: "Awesome Movie Title",
                      language: "English",
                      torrents: [], // Assuming torrents are handled elsewhere
                    ),
                    height: context.screenHeight(.4),
                    width: context.screenWidth(.5));
              },
            )
          ],
        ),
      ),
    );
  }
}
