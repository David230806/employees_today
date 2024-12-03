part of 'workday_bloc.dart';

@immutable
sealed class WorkdayEvent {}

class FinishWorkdayEvent extends WorkdayEvent {
  final WorkdayModel workday;

  FinishWorkdayEvent({required this.workday});
}

class StartWorkdayEvent extends WorkdayEvent {
  final DateTime dateStart;
  final String userId;

  StartWorkdayEvent({
    required this.dateStart,
    required this.userId,
  });
}
