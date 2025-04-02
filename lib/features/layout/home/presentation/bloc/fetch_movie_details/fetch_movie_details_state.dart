part of 'fetch_movie_details_cubit.dart';

@immutable
sealed class FetchMovieDetailsState   {}

final class FetchMovieDetailsInitial extends FetchMovieDetailsState {

}

final class FetchMovieDetailsSuccess extends FetchMovieDetailsState {
  final MovieDetailsEntity movie;

  FetchMovieDetailsSuccess({required this.movie});

}

final class FetchMovieDetailsFailure extends FetchMovieDetailsState {
  final String errMessage;

  FetchMovieDetailsFailure({required this.errMessage});

}

final class FetchMovieDetailsLoading extends FetchMovieDetailsState {
}


// part of 'fetch_movie_details_cubit.dart';

// @immutable
// sealed class FetchMovieDetailsState extends Equatable {}

// final class FetchMovieDetailsInitial extends FetchMovieDetailsState {
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }

// final class FetchMovieDetailsSuccess extends FetchMovieDetailsState {
//   final MovieDetailsEntity movie;

//   FetchMovieDetailsSuccess({required this.movie});

//   @override
//   List<Object?> get props => [movie];
// }

// final class FetchMovieDetailsFailure extends FetchMovieDetailsState {
//   final String errMessage;

//   FetchMovieDetailsFailure({required this.errMessage});

//   @override
//   List<Object?> get props => [errMessage];
// }

// final class FetchMovieDetailsLoading extends FetchMovieDetailsState {
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }
