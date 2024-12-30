import 'package:employees_today/core/configs/theme/app_colors.dart';
import 'package:employees_today/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:employees_today/features/history/presentation/bloc/history/history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      // style
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          color: AppColors.text,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        weekendStyle: TextStyle(
          color: AppColors.text,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
        headerPadding: EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        titleTextStyle: TextStyle(
          color: AppColors.text,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      ),
      daysOfWeekHeight: 30,
      calendarStyle: CalendarStyle(
        defaultTextStyle: const TextStyle(
          color: AppColors.text,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        weekendTextStyle: const TextStyle(
          color: AppColors.text,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        selectedTextStyle: const TextStyle(
          color: AppColors.text,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        todayTextStyle: const TextStyle(
          color: AppColors.text,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        selectedDecoration: BoxDecoration(
          color: AppColors.assent,
          borderRadius: BorderRadius.circular(10),
        ),
        weekendDecoration: const BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        todayDecoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(10),
        ),
        defaultDecoration: const BoxDecoration(
          shape: BoxShape.rectangle,
        ),
      ),
      // logic
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      calendarFormat: CalendarFormat.week,
      onDaySelected: (selectedDay, focusedDay) {
        context.read<HistoryBloc>().add(GetWorkdayByDayEvent(date: selectedDay));
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      onPageChanged: (focusedDay) {
        final weekStart = focusedDay.subtract(Duration(days: focusedDay.weekday - 1));
        final weekEnd = weekStart.add(const Duration(days: 6));

        _focusedDay = focusedDay;

        context.read<HistoryBloc>().add(
              GetWorkdayByDateEvent(
                userId: (context.read<AuthBloc>().state as SignInSuccessState).user.id,
                dateStart: weekStart,
                dateEnd: weekEnd,
              ),
            );
      },
      focusedDay: _focusedDay,
      firstDay: DateTime(2010, 1, 1),
      lastDay: DateTime(2030, 12, 31),
    );
  }
}
