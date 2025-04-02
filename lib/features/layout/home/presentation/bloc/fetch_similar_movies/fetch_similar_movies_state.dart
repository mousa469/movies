part of 'fetch_similar_movies_cubit.dart';

sealed class FetchSimilarMoviesState extends Equatable {
  const FetchSimilarMoviesState();

  @override
  List<Object> get props => [];
}

final class FetchSimilarMoviesInitial extends FetchSimilarMoviesState {}

final class FetchSimilarMoviesLoading extends FetchSimilarMoviesState {}

final class FetchSimilarMoviesSucces extends FetchSimilarMoviesState {
  final List<MovieEntity> movies;

 const  FetchSimilarMoviesSucces({required this.movies});
}

final class FetchSimilarMoviesFailure extends FetchSimilarMoviesState {
  final String errMessage;

  const  FetchSimilarMoviesFailure({required this.errMessage});
}
