part of 'start_work_bloc.dart';

@immutable
sealed class StartWorkState {}

final class StartWorkInitial extends StartWorkState {}

final class StartWorkLoading extends StartWorkState {}

final class StartWorkStarted extends StartWorkState {
  final DateTime date;

  StartWorkStarted({required this.date});
}

final class StartWorkFinished extends StartWorkState {
  final DateTime date;

  StartWorkFinished({required this.date});
}
