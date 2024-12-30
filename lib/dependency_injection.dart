import 'package:employees_today/features/auth/data/repositories/auth_repository.dart';
import 'package:employees_today/features/auth/domain/repositories/auth_repository.dart';
import 'package:employees_today/features/history/data/repository/history_repository.dart';
import 'package:employees_today/features/history/domain/repository/history_repository.dart';
import 'package:employees_today/features/home/data/repositories/workday_repository.dart';
import 'package:employees_today/features/home/domain/repositories/workday_repository.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initialize() async {
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<WorkdayRepository>(WorkdayRepositoryImpl());
  sl.registerSingleton<HistoryRepository>(HistoryRepositoryImpl());
}
