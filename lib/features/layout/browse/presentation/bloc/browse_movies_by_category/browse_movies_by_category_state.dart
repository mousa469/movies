part of 'browse_movies_by_category_cubit.dart';

sealed class BrowseMoviesByCategoryState extends Equatable {
  const BrowseMoviesByCategoryState();

  @override
  List<Object> get props => [];
}

final class BrowseMoviesByCategoryInitial extends BrowseMoviesByCategoryState {}

final class BrowseMoviesByCategorySuccess extends BrowseMoviesByCategoryState {
  final List<MovieEntity> movies;
  const BrowseMoviesByCategorySuccess({required this.movies});
}

final class BrowseMoviesByCategoryFailure extends BrowseMoviesByCategoryState {
  final String errMessage;
  const BrowseMoviesByCategoryFailure({required this.errMessage});
}

final class BrowseMoviesByCategoryLoading extends BrowseMoviesByCategoryState {}
