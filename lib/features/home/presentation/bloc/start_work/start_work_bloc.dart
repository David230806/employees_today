import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'start_work_event.dart';
part 'start_work_state.dart';

class StartWorkBloc extends Bloc<StartWorkEvent, StartWorkState> {
  StartWorkBloc() : super(StartWorkInitial()) {
    on<StartWorkEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
