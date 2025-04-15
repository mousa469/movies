part of 'search_movie_cubit.dart';

sealed class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

final class SearchMovieInitial extends SearchMovieState {}

final class SearchMovieSuccess extends SearchMovieState {
  final List<MovieEntity> movies;
  const SearchMovieSuccess({required this.movies});
  @override
  List<Object> get props => [movies];
}

final class SearchMovieFailure extends SearchMovieState {
  final String message;
  const SearchMovieFailure({required this.message});
}

final class SearchMovieLoading extends SearchMovieState {}
