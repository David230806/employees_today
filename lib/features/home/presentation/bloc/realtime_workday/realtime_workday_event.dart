part of 'realtime_workday_bloc.dart';

@immutable
sealed class RealtimeWorkdayEvent {}

class UpdateRealtimeWorkdayEvent extends RealtimeWorkdayEvent {
  final RealtimeWorkdayModel realtimeWorkday;

  UpdateRealtimeWorkdayEvent(this.realtimeWorkday);
}
