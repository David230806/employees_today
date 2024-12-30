import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:employees_today/features/home/data/models/realtime_workday.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

part 'realtime_workday_event.dart';
part 'realtime_workday_state.dart';

class RealtimeWorkdayBloc extends Bloc<RealtimeWorkdayEvent, RealtimeWorkdayState> {
  StreamSubscription? _realtimeWorkdaySubscription;

  String userId = "";

  RealtimeWorkdayBloc() : super(RealtimeWorkdayInitial()) {
    final DatabaseReference usersRef = FirebaseDatabase.instance.ref('users/$userId');

    print(userId);

    _realtimeWorkdaySubscription = usersRef.onValue.listen((event) async {
      log(event.snapshot.exists.toString());
      try {
        if (event.snapshot.exists) {
          log("DATA: ${(event.snapshot.value as Map)[userId]}");
          final data = Map<String, dynamic>.from((event.snapshot.value as Map)[userId]);

          final RealtimeWorkdayModel workday = RealtimeWorkdayModel.fromJson(data);

          log("WORKDAY: ${workday.toString()}");

          // if (workday.isWorkdayEnded == false) {
          //   await usersRef.set({
          //     "dateEnd": "null",
          //     "dateStart": "null",
          //     "status": "offline",
          //   });
          // }

          log(workday.toString());

          emit(RealtimeWorkdaySuccess(realtimeWorkday: workday));
        } else {
          log("User data not found");
          emit(RealtimeWorkdayFailed(error: "User data not found or deleted."));
        }
      } catch (e) {
        log("Realtime $e");
        emit(RealtimeWorkdayFailed(error: "Something went wrong"));
      }
    });

    on<UpdateRealtimeWorkdayEvent>(_onUpdateRealtimeWorkday);
  }

  void dispose() {
    _realtimeWorkdaySubscription?.cancel();
  }

  void setUserId(String id) {
    userId = id;
  }

  _onUpdateRealtimeWorkday(
      UpdateRealtimeWorkdayEvent event, Emitter<RealtimeWorkdayState> emit) async {
    emit(RealtimeWorkdayLoading());

    final DatabaseReference usersRef = FirebaseDatabase.instance.ref('users/$userId');

    log("UserId: $userId");

    try {
      await usersRef.set({
        "dateEnd": event.realtimeWorkday.dateEnd!.toIso8601String(),
        "dateStart": event.realtimeWorkday.dateStart!.toIso8601String(),
        "status": event.realtimeWorkday.status.name,
      });

      emit(RealtimeWorkdaySuccess(realtimeWorkday: event.realtimeWorkday));
    } catch (e) {
      log(e.toString());
      emit(RealtimeWorkdayFailed(error: e.toString()));
    }
  }
}
