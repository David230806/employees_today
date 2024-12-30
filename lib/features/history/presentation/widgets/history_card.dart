import 'package:employees_today/features/history/presentation/bloc/history/history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state is HistoryByDayLoaded) {
          return Container(
            child: Center(
              child: Text(state.workday.startDate.toString()),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
