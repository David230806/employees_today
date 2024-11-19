part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class VerifyNumberLoadingState extends AuthState {}

final class VerifyNumberSuccessState extends AuthState {
  final String verificationId;

  VerifyNumberSuccessState({required this.verificationId});
}

final class VerifyNumberFailedState extends AuthState {
  final String error;

  VerifyNumberFailedState({required this.error});
}

final class SignInLoadingState extends AuthState {}

final class SignInSuccessState extends AuthState {
  final UserEntity user;

  SignInSuccessState({required this.user});
}

final class SignInFailedState extends AuthState {
  final String error;

  SignInFailedState({required this.error});
}
