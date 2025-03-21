part of 'add_movie_to_wishlist_cubit.dart';

@immutable
sealed class AddMovieToWishlistState {}

final class AddMovieToWishlistInitial extends AddMovieToWishlistState {}

final class AddMovieToWishlistSuccess extends AddMovieToWishlistState {}

final class AddMovieToWishlistFailure extends AddMovieToWishlistState {
  final String errMessage;

  AddMovieToWishlistFailure({required this.errMessage});
}

final class AddMovieToWishlistLoading extends AddMovieToWishlistState {}
