part of 'number_of_history_movies_cubit.dart';

sealed class NumberOfHistoryMoviesState extends Equatable {
  const NumberOfHistoryMoviesState();

  @override
  List<Object> get props => [];
}

final class NumberOfHistoryMoviesInitial extends NumberOfHistoryMoviesState {}

final class NumberOfHistoryMoviesSuccess extends NumberOfHistoryMoviesState {
  final int numberOfMovies;

  const NumberOfHistoryMoviesSuccess({required this.numberOfMovies});
}

final class NumberOfHistoryMoviesFailure extends NumberOfHistoryMoviesState {
  final String errMessage;

  const NumberOfHistoryMoviesFailure({required this.errMessage});
}

final class NumberOfHistoryMoviesLoading extends NumberOfHistoryMoviesState {}
