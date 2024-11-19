part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class VerifyNumberEvent extends AuthEvent {
  final String number;

  VerifyNumberEvent({required this.number});
}

class SignInEvent extends AuthEvent {
  final String verificationId;
  final String otpCode;

  SignInEvent({
    required this.verificationId,
    required this.otpCode,
  });
}
