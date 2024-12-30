import 'package:dartz/dartz.dart';
import 'package:employees_today/features/home/data/models/workday.dart';
import 'package:employees_today/features/home/domain/entity/workday.dart';

abstract class WorkdayRepository {
  Future<Either<String, WorkdayEntity>> getWorkdayById(String workdayId);
  Future<Either<String, List<WorkdayEntity>>> getWorkdaysByUser(
    String userId,
    DateTime date,
  );
  Future<Either<String, String>> createWorkday(WorkdayModel workday);
}
