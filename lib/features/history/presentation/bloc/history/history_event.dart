part of 'history_bloc.dart';

@immutable
sealed class HistoryEvent {}

class GetWorkdayByDateEvent extends HistoryEvent {
  final String userId;
  final DateTime dateStart;
  final DateTime dateEnd;

  GetWorkdayByDateEvent({
    required this.userId,
    required this.dateStart,
    required this.dateEnd,
  });
}

class GetWorkdayByDayEvent extends HistoryEvent {
  final DateTime date;

  GetWorkdayByDayEvent({
    required this.date,
  });
}
