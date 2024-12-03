import 'package:employees_today/features/home/domain/enum/working_status.dart';

class RealtimeWorkdayEntity {
  final EWorkingStatus status;
  final DateTime? dateStart;
  final DateTime? dateEnd;

  RealtimeWorkdayEntity({
    required this.status,
    required this.dateStart,
    required this.dateEnd,
  });
}
