import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either> signin(String verificationId, String otpCode);
}
