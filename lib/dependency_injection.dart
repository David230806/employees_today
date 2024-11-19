import 'package:employees_today/features/auth/data/repositories/auth_repository.dart';
import 'package:employees_today/features/auth/domain/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initialize() async {
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
}
