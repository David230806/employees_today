import 'dart:developer';

import 'package:employees_today/features/home/domain/entity/realtime_workday.dart';
import 'package:employees_today/features/home/domain/enum/working_status.dart';

class RealtimeWorkdayModel extends RealtimeWorkdayEntity {
  RealtimeWorkdayModel({
    required super.status,
    required super.dateStart,
    required super.dateEnd,
  });

  factory RealtimeWorkdayModel.fromJson(Map<String, dynamic> json) {
    log("""RealtimeWorkDay {
      status: ${json['status']},
      dateStart: ${json['dateStart']},
      dateEnd: ${json['dateEnd']},
    }""");

    return RealtimeWorkdayModel(
      status: EWorkingStatus.values.byName(json['status']),
      dateStart: json['dateStart'] == "null" ? null : DateTime.parse(json['dateStart']),
      dateEnd: json['dateEnd'] == "null" ? null : DateTime.parse(json['dateEnd']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status.toString(),
      "dateStart": dateStart.toString(),
      "dateEnd": dateEnd.toString(),
    };
  }
}
