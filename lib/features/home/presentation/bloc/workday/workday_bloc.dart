import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:employees_today/features/home/data/models/workday.dart';
import 'package:employees_today/features/home/domain/repositories/workday_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

part 'workday_event.dart';
part 'workday_state.dart';

class WorkdayBloc extends Bloc<WorkdayEvent, WorkdayState> {
  final WorkdayRepository _workdayRepository;

  WorkdayBloc(this._workdayRepository) : super(WorkdayInitial()) {
    on<FinishWorkdayEvent>(_onWorkdayFinish);
    on<StartWorkdayEvent>(_onWorkdayStart);
  }

  final realtimeDatabase = FirebaseDatabase.instance;

  _onWorkdayStart(StartWorkdayEvent event, Emitter<WorkdayState> emit) async {
    emit(WorkdayLoadingState());

    final realtimeDatabaseRef = realtimeDatabase.ref("users/${event.userId}");

    try {
      await realtimeDatabaseRef.set({
        "dateEnd": "null",
        "dateStart": event.dateStart.toIso8601String(),
        "status": "online",
      });

      emit(WorkdayStartedState());
    } catch (e) {
      emit(WorkdayErrorState(message: e.toString()));
    }
  }

  _onWorkdayFinish(FinishWorkdayEvent event, Emitter<WorkdayState> emit) async {
    emit(WorkdayLoadingState());

    final Either<String, String> res = await _workdayRepository.createWorkday(event.workday);

    res.fold(
      (l) {
        log(l);
        emit(WorkdayErrorState(message: l));
      },
      (r) async {
        emit(WorkdayFinishedState(message: r));
      },
    );
  }
}
