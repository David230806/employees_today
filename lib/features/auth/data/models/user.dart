import 'package:employees_today/features/auth/domain/entities/user.dart';
import 'package:employees_today/features/auth/domain/enum/role.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.surname,
    super.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      role: ERole.values.byName(json['role']),
    );
  }

  factory UserModel.fromFirebase(UserCredential user) {
    return UserModel(
      id: user.user!.uid,
      name: user.user?.displayName ?? "",
      surname: "",
    );
  }
}
