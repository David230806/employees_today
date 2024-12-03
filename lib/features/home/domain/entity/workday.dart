class WorkdayEntity {
  final String id;
  final String employeeId;
  final DateTime? startDate;
  final DateTime? endDate;

  WorkdayEntity({
    required this.id,
    required this.employeeId,
    required this.startDate,
    required this.endDate,
  });
}
