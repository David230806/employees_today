import 'package:employees_today/features/auth/data/repositories/auth_repository.dart';
import 'package:employees_today/features/auth/domain/repositories/auth_repository.dart';
import 'package:employees_today/features/home/data/repositories/workday_repository.dart';
import 'package:employees_today/features/home/domain/repositories/workday_repository.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initialize() async {
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<WorkdayRepository>(WorkdayRepositoryImpl());
}
