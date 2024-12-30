import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:employees_today/features/history/domain/repository/history_repository.dart';
import 'package:employees_today/features/home/data/models/workday.dart';
import 'package:employees_today/features/home/domain/entity/workday.dart';

class HistoryRepositoryImpl extends HistoryRepository {
  @override
  Future<Either<String, List<WorkdayEntity>>> getWorkdayByDate(
      String userId, DateTime dateStart, DateTime dateEnd) async {
    final FirebaseFirestore storage = FirebaseFirestore.instance;

    try {
      final data = await storage
          .collection('workdays')
          .where('employeeId', isEqualTo: userId)
          // .where("startDate", isGreaterThanOrEqualTo: dateStart.toString())
          // .where("endDate", isLessThanOrEqualTo: dateEnd.toString())
          .get();

      final List<WorkdayEntity> workdays =
          data.docs.map((doc) => WorkdayModel.fromJson(doc.data())).toList();

      return Right(workdays);
    } catch (e) {
      log("History error: $e");
      return Left(e.toString());
    }
  }
}
