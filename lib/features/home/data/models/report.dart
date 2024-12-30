import 'package:employees_today/features/home/domain/entity/report.dart';

class ReportModel extends ReportEntity {
  ReportModel({required super.id, required super.count});

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "count": count,
    };
  }
}
