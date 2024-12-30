import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:employees_today/features/history/domain/repository/history_repository.dart';
import 'package:employees_today/features/home/domain/entity/workday.dart';
import 'package:meta/meta.dart';
import 'package:table_calendar/table_calendar.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository _historyRepository;

  HistoryBloc(this._historyRepository) : super(HistoryInitial()) {
    on<GetWorkdayByDateEvent>(_onGetWorkdayByDate);
    on<GetWorkdayByDayEvent>(_onGetWorkdayByDay);
  }

  List<WorkdayEntity> workdays = [];

  _onGetWorkdayByDate(GetWorkdayByDateEvent event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    final result = await _historyRepository.getWorkdayByDate(
      event.userId,
      event.dateStart,
      event.dateEnd,
    );

    result.fold(
      (error) => emit(HistoryError(error)),
      (loadedWorkdays) {
        workdays = loadedWorkdays;
        final WorkdayEntity workday = workdays.firstWhere(
          (element) => isSameDay(element.startDate, DateTime.now()),
        );

        emit(HistoryByDayLoaded(workday));
      },
    );
  }

  _onGetWorkdayByDay(GetWorkdayByDayEvent event, Emitter<HistoryState> emit) {
    log(workdays.toString());
    final WorkdayEntity workday = workdays.firstWhere((element) =>
        element.startDate.toString().substring(0, 10) == event.date.toString().substring(0, 10));

    emit(HistoryByDayLoaded(workday));
  }
}
