import 'package:employees_today/core/configs/theme/app_colors.dart';
import 'package:employees_today/core/widgets/calendar.dart';
import 'package:employees_today/core/widgets/scaffold_wrapper.dart';
import 'package:employees_today/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:employees_today/features/history/presentation/bloc/history/history_bloc.dart';
import 'package:employees_today/features/history/presentation/widgets/history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HistoryBloc, HistoryState>(
      listener: (context, state) {
        if (state is HistoryInitial) {
          final now = DateTime.now();
          final weekStart = now.subtract(Duration(days: now.weekday - 1));
          final weekEnd = weekStart.add(const Duration(days: 6));

          context.read<HistoryBloc>().add(
                GetWorkdayByDateEvent(
                  userId: (context.read<AuthBloc>().state as SignInSuccessState).user.id,
                  dateStart: weekStart,
                  dateEnd: weekEnd,
                ),
              );
        }
      },
      child: DecorationWrapper(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 40.0,
            right: 20,
            left: 20,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Column(
              children: [
                Text(
                  'История',
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 26,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Calendar(),
                HistoryCard()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
