import 'package:dartz/dartz.dart';
import 'package:employees_today/features/home/domain/entity/workday.dart';

abstract class HistoryRepository {
  Future<Either<String, List<WorkdayEntity>>> getWorkdayByDate(String userId, DateTime dateStart, DateTime dateEnd);
}
