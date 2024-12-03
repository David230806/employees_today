import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:employees_today/features/home/data/models/realtime_workday.dart';
import 'package:employees_today/features/home/domain/entity/realtime_workday.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

part 'realtime_workday_event.dart';
part 'realtime_workday_state.dart';

class RealtimeWorkdayBloc extends Bloc<RealtimeWorkdayEvent, RealtimeWorkdayState> {
  StreamSubscription? _realtimeWorkdaySubscription;

  String userId = "";

  RealtimeWorkdayBloc() : super(RealtimeWorkdayInitial()) {
    final DatabaseReference usersRef = FirebaseDatabase.instance.ref('users/$userId');

    _realtimeWorkdaySubscription = usersRef.onValue.listen((event) {
      log(event.snapshot.exists.toString());
      try {
        if (event.snapshot.exists) {
          final data = Map<String, dynamic>.from((event.snapshot.value as Map)[userId]);

          log("DATA: ${data.runtimeType}");

          final RealtimeWorkdayEntity workday = RealtimeWorkdayModel.fromJson(data);

          log(workday.toString());

          emit(RealtimeWorkdaySuccess(realtimeWorkday: workday));
        } else {
          log("User data not found");
          emit(RealtimeWorkdayFailed(error: "User data not found or deleted."));
        }
      } catch (e) {
        log(e.toString());
        emit(RealtimeWorkdayFailed(error: "Something went wrong"));
      }
    });
  }

  void dispose() {
    _realtimeWorkdaySubscription?.cancel();
  }

  void setUserId(String id) {
    userId = id;
  }
}
