part of 'fetch_number_movies_in_watch_list_cubit.dart';

sealed class FetchNumberMoviesInWatchListState extends Equatable {
  const FetchNumberMoviesInWatchListState();

  @override
  List<Object> get props => [];
}

final class FetchNumberMoviesInWatchListInitial
    extends FetchNumberMoviesInWatchListState {}

final class FetchNumberMoviesInWatchListLoading
    extends FetchNumberMoviesInWatchListState {}

final class FetchNumberMoviesInWatchListFailure
    extends FetchNumberMoviesInWatchListState {
  final String errMessage;

  const FetchNumberMoviesInWatchListFailure({required this.errMessage});
}

final class FetchNumberMoviesInWatchListSuccess
    extends FetchNumberMoviesInWatchListState {
  final int  numberOfMovies;

  const FetchNumberMoviesInWatchListSuccess({required this.numberOfMovies});
}
