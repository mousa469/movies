part of 'fetch_user_data_cubit.dart';

sealed class FetchUserDataState extends Equatable {
  const FetchUserDataState();

  @override
  List<Object> get props => [];
}

final class FetchUserDataInitial extends FetchUserDataState {}

final class FetchUserDataLoading extends FetchUserDataState {}

final class FetchUserDataFailure extends FetchUserDataState {
  final String errMessage;

  const FetchUserDataFailure({required this.errMessage});
}

final class FetchUserDataSuccess extends FetchUserDataState {
  final UserProfileEntity user;

 const  FetchUserDataSuccess({required this.user});
}
