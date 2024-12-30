import 'package:dartz/dartz.dart';
import 'package:employees_today/features/auth/data/models/user.dart';
import 'package:employees_today/features/auth/domain/entities/user.dart';
import 'package:employees_today/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signin(String verificationId, String otpCode) async {
    final firebaseInstance = FirebaseAuth.instance;

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );

      final UserCredential userFromFirebase =
          await firebaseInstance.signInWithCredential(credential);

      if (userFromFirebase.user == null) {
        return const Left("User is null");
      }

      final UserEntity user = UserModel.fromFirebase(userFromFirebase);

      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
