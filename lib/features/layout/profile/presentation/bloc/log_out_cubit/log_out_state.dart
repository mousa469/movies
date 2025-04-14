part of 'log_out_cubit.dart';

sealed class LogOutState extends Equatable {
  const LogOutState();

  @override
  List<Object> get props => [];
}

final class LogOutInitial extends LogOutState {}

final class LogOutSuccess extends LogOutState {
  final String successMessage;

  const LogOutSuccess({required this.successMessage});
}

final class LogOutFailure extends LogOutState {
  final String errMessage;

  const LogOutFailure({required this.errMessage});
}
