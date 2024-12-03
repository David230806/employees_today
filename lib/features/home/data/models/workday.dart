import 'package:employees_today/features/home/domain/entity/workday.dart';

class WorkdayModel extends WorkdayEntity {
  WorkdayModel({
    required super.id,
    required super.employeeId,
    required super.startDate,
    required super.endDate,
  });

  factory WorkdayModel.fromJson(Map<String, dynamic> json) {
    return WorkdayModel(
      id: json['id'],
      employeeId: json['employeeId'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "employeeid": employeeId,
      "startDate": startDate.toString(),
      "endDate": endDate.toString(),
    };
  }
}
