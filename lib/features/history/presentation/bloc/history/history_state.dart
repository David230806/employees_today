part of 'history_bloc.dart';

@immutable
sealed class HistoryState {}

final class HistoryInitial extends HistoryState {}

final class HistoryLoading extends HistoryState {}

final class HistoryLoaded extends HistoryState {
  final List<WorkdayEntity> workdays;

  HistoryLoaded(this.workdays);
}

final class HistoryError extends HistoryState {
  final String message;

  HistoryError(this.message);
}

final class HistoryByDayLoaded extends HistoryState {
  final WorkdayEntity workday;

  HistoryByDayLoaded(this.workday);
}
