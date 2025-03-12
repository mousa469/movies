part of 'available_movies_cubit.dart';

@immutable
sealed class AvailableMoviesState {}

final class AvailableMoviesInitial extends AvailableMoviesState {}

final class AvailableMoviesSuccess extends AvailableMoviesState {
  final List<MovieEntity> movies;

  AvailableMoviesSuccess({required this.movies});

}

final class AvailableMoviesFailure extends AvailableMoviesState {
  final String errMessage;

  AvailableMoviesFailure({required this.errMessage});
}

final class AvailableMoviesLoading extends AvailableMoviesState {}
