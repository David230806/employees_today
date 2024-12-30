part of 'realtime_workday_bloc.dart';

@immutable
sealed class RealtimeWorkdayState {}

final class RealtimeWorkdayInitial extends RealtimeWorkdayState {}
final class RealtimeWorkdayLoading extends RealtimeWorkdayState {}
final class RealtimeWorkdaySuccess extends RealtimeWorkdayState {
  final RealtimeWorkdayModel realtimeWorkday;

  RealtimeWorkdaySuccess({required this.realtimeWorkday});
}
final class RealtimeWorkdayFailed extends RealtimeWorkdayState {
  final String error;

  RealtimeWorkdayFailed({required this.error});
}
