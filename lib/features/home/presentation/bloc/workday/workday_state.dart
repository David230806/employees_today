part of 'workday_bloc.dart';

@immutable
sealed class WorkdayState {}

final class WorkdayInitial extends WorkdayState {}

final class WorkdayLoadingState extends WorkdayState {}

final class WorkdayErrorState extends WorkdayState {
  final String message;

  WorkdayErrorState({required this.message});
}

final class WorkdayStartedState extends WorkdayState {}

final class WorkdayFinishedState extends WorkdayState {
  final String message;

  WorkdayFinishedState({required this.message});
}
