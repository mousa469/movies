part of 'fetch_list_of_movies_cubit.dart';

sealed class FetchListOfMoviesState extends Equatable {
  const FetchListOfMoviesState();

  @override
  List<Object> get props => [];
}

final class FetchListOfMoviesInitial extends FetchListOfMoviesState {}

final class FetchListOfMoviesSuccess extends FetchListOfMoviesState {
  final List<MovieEntity> movies;
  const FetchListOfMoviesSuccess({required this.movies});
  @override
  List<Object> get props => [movies];
}

final class FetchListOfMoviesFailure extends FetchListOfMoviesState {
  final String errMessage;
  const FetchListOfMoviesFailure({required this.errMessage});
}

final class FetchListOfMoviesLoading extends FetchListOfMoviesState {}
