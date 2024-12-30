import 'package:employees_today/features/home/data/models/report.dart';

class WorkdayEntity {
  final String id;
  final String employeeId;
  final DateTime? startDate;
  final DateTime? endDate;
  final ReportModel report;

  WorkdayEntity({
    required this.id,
    required this.employeeId,
    required this.startDate,
    required this.endDate,
    required this.report,
  });
}
