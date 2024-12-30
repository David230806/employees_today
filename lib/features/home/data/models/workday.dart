import 'package:employees_today/features/home/data/models/report.dart';
import 'package:employees_today/features/home/domain/entity/workday.dart';

class WorkdayModel extends WorkdayEntity {
  WorkdayModel({
    required super.id,
    required super.employeeId,
    required super.startDate,
    required super.endDate,
    required super.report,
  });

  factory WorkdayModel.fromJson(Map<String, dynamic> json) {
    return WorkdayModel(
      id: json['id'],
      employeeId: json['employeeId'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      report: ReportModel.fromJson(json['report'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "employeeid": employeeId,
      "startDate": startDate.toString(),
      "endDate": endDate.toString(),
      "report": report.toJson(),
    };
  }
}
