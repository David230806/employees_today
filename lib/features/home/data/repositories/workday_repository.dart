import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:employees_today/features/home/data/models/workday.dart';
import 'package:employees_today/features/home/domain/entity/workday.dart';
import 'package:employees_today/features/home/domain/repositories/workday_repository.dart';

class WorkdayRepositoryImpl extends WorkdayRepository {
  final FirebaseFirestore storage = FirebaseFirestore.instance;

  @override
  Future<Either<String, String>> createWorkday(WorkdayModel workday) async {
    try {
      await storage.collection('workdays').add(workday.toJson());

      return const Right("Workday created successfully");
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, WorkdayEntity>> getWorkdayById(String workdayId) {
    // TODO: implement getWorkdayById
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<WorkdayEntity>>> getWorkdaysByUser(
    String userId,
    DateTime date,
  ) async {
    try {
      final data = await storage
          .collection('workdays')
          .where('employeeId', isEqualTo: userId)
          .get();

      final List<WorkdayEntity> workdays =
          data.docs.map((doc) => WorkdayModel.fromJson(doc.data())).toList();

      return Right(workdays);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
