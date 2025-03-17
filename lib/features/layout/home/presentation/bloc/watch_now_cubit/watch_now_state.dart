part of 'watch_now_cubit.dart';

@immutable
sealed class WatchNowState {}

final class WatchNowInitial extends WatchNowState {}

final class WatchNowSuccess extends WatchNowState {
 final  List<MovieEntity> movies;

  WatchNowSuccess({required this.movies});
}

final class WatchNowLoading extends WatchNowState {}

final class WatchNowFailure extends WatchNowState {
  final String errMessage;

  WatchNowFailure({required this.errMessage});
}
