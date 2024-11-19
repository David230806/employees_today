import 'package:employees_today/features/auth/domain/enum/role.dart';

class UserEntity {
  final String id;
  final String name;
  final String surname;
  final ERole role;

  UserEntity({
    required this.id,
    required this.name,
    required this.surname,
    this.role = ERole.employee,
  });
}
