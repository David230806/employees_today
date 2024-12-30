import 'dart:developer';

import 'package:employees_today/core/common/helpers/month_title.dart';
import 'package:employees_today/core/common/helpers/week_day_title.dart';
import 'package:employees_today/core/configs/theme/app_colors.dart';
import 'package:employees_today/core/widgets/base_button.dart';
import 'package:employees_today/core/widgets/charts/bar_chart.dart';
import 'package:employees_today/core/widgets/charts/pie_chart.dart';
import 'package:employees_today/core/widgets/scaffold_wrapper.dart';
import 'package:employees_today/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:employees_today/features/home/data/models/realtime_workday.dart';
import 'package:employees_today/features/home/data/models/report.dart';
import 'package:employees_today/features/home/data/models/workday.dart';
import 'package:employees_today/features/home/domain/entity/realtime_workday.dart';
import 'package:employees_today/features/home/domain/enum/working_status.dart';
import 'package:employees_today/features/home/presentation/bloc/realtime_workday/realtime_workday_bloc.dart';
import 'package:employees_today/features/home/presentation/bloc/workday/workday_bloc.dart';
import 'package:employees_today/features/home/presentation/widgets/start_work_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  double productCount = 0;

  @override
  Widget build(BuildContext context) {
    return DecorationWrapper(
      appBar: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 50,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is SignInSuccessState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Hello",
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          "${state.user.name} ${state.user.surname}",
                          style: const TextStyle(
                            color: AppColors.text,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }

                  return const SizedBox();
                },
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Iconsax.menu,
                  color: AppColors.assent,
                ),
              ),
            ],
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 30,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<RealtimeWorkdayBloc, RealtimeWorkdayState>(
                builder: (context, state) {
                  if (state is RealtimeWorkdaySuccess) {
                    return Column(
                      children: [
                        _buildStartWorkContainer(state.realtimeWorkday, context),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildTimeStatContainer(state.realtimeWorkday),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      _buildStartWorkContainer(null, context),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildTimeStatContainer(null),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Статистика за сегодня",
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _buildBarChart(),
              const SizedBox(
                height: 10,
              ),
              _buildPieChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Кол-во изготовленное продукции",
            style: TextStyle(
              color: AppColors.text,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomBarChart(),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    return Container(
      width: double.infinity,
      height: 325,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Кол-во брака",
            style: TextStyle(
              color: AppColors.text,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomPieChart(
            indicators: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.greenAccent.shade400,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Не брак",
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.redAccent.shade400,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Брак",
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ],
            ),
            values: const [
              40,
              60,
            ],
            colors: [
              Colors.redAccent.shade400,
              Colors.greenAccent.shade400,
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeStatContainer(RealtimeWorkdayEntity? workday) {
    Duration? getDifferenceStartAndEnd() {
      if (workday == null || workday.dateStart == null) {
        return null;
      }

      if (workday.dateEnd == null) {
        return DateTime.now().difference(workday.dateStart!);
      }

      return workday.dateEnd!.difference(workday.dateStart!);
    }

    String addZeroToDate(int num) {
      if (num < 10) {
        return "0$num";
      }

      return num.toString();
    }

    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Icon(
                Icons.timelapse_rounded,
                color: Colors.teal,
              ),
              Text(
                workday?.dateStart != null
                    ? "${addZeroToDate(workday!.dateStart!.hour)}:${addZeroToDate(workday.dateStart!.minute)}"
                    : "--:--",
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.text,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                "Прибытие",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.text,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.av_timer_rounded,
                color: Colors.amber.shade600,
              ),
              Text(
                workday?.dateEnd != null
                    ? "${addZeroToDate(workday!.dateEnd!.hour)}:${addZeroToDate(workday.dateEnd!.minute)}"
                    : "--:--",
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.text,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                "Уход",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.text,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Icon(
                Icons.access_time_rounded,
                color: AppColors.assent,
              ),
              Text(
                getDifferenceStartAndEnd() != null
                    ? "${addZeroToDate(getDifferenceStartAndEnd()!.inHours % 24)}:${addZeroToDate(getDifferenceStartAndEnd()!.inMinutes % 60)}"
                    : "--:--",
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.text,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                "Рабочие часы",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.text,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStartWorkContainer(RealtimeWorkdayModel? workday, BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "${DateTime.now().hour < 10 ? "0${DateTime.now().hour}" : DateTime.now().hour}:${DateTime.now().minute < 10 ? "0${DateTime.now().minute}" : DateTime.now().minute}",
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 26,
            ),
          ),
          Text(
            "${DateTime.now().weekDayTitle}, ${DateTime.now().monthTitle} ${DateTime.now().day}",
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final userId = state is SignInSuccessState ? state.user.id : "";

              void createWorkday(ReportModel report) {
                context.read<WorkdayBloc>().add(
                      FinishWorkdayEvent(
                        workday: WorkdayModel(
                          id: const Uuid().v4(),
                          employeeId: userId,
                          startDate: workday!.dateStart,
                          endDate: DateTime.now(),
                          report: report,
                        ),
                      ),
                    );
              }

              return GestureDetector(
                onTap: () {
                  if (workday != null && workday.status == EWorkingStatus.offline) {
                    if (workday.isWorkdayEnded) {
                      log('Workday already finished');
                      return;
                    }

                    context
                        .read<WorkdayBloc>()
                        .add(StartWorkdayEvent(dateStart: DateTime.now(), userId: userId));
                  } else {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        int boxCount = 3;

                        return _buildReportModalSheet(context, workday, boxCount, createWorkday);
                      },
                    );
                  }
                },
                child: StartWorkButton(
                  workday: workday ??
                      RealtimeWorkdayModel(
                        status: EWorkingStatus.offline,
                        dateStart: null,
                        dateEnd: null,
                      ),
                ),
              );
            },
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Iconsax.location,
                color: AppColors.text,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Локация: ${workday != null && workday.status == EWorkingStatus.online ? "На работе" : "Не на работе"}",
                style: const TextStyle(
                  color: AppColors.text,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportModalSheet(
    BuildContext context,
    RealtimeWorkdayEntity? workday,
    int boxCount,
    void Function(ReportModel report) createReport,
  ) {
    return BlocConsumer<WorkdayBloc, WorkdayState>(
      listener: (context, state) {
        log(state.toString());

        if (state is WorkdayFinishedState) {
          if (workday != null) {
            context.read<RealtimeWorkdayBloc>().add(
                  UpdateRealtimeWorkdayEvent(
                    RealtimeWorkdayModel(
                      status: EWorkingStatus.offline,
                      dateStart: workday.dateStart,
                      dateEnd: DateTime.now(),
                    ),
                  ),
                );
          }

          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return Wrap(
            children: [
              Container(
                height: MediaQuery.of(context).viewInsets.bottom == 0.0 ? 680 : 800,
                width: double.infinity,
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: AppColors.background,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Ежедневный отчёт",
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Начало рабочего дня",
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          readOnly: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                                  hintText: workday == null
                                      ? "--:--"
                                      : "${workday.dateStart.toString().substring(0, 10)} ${workday.dateStart!.hour < 10 ? "0${workday.dateStart!.hour}" : workday.dateStart!.hour}:${workday.dateStart!.minute < 10 ? "0${workday.dateStart!.minute}" : workday.dateStart!.minute}")
                              .applyDefaults(Theme.of(context).inputDecorationTheme),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Конец рабочего дня",
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          readOnly: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                                  hintText: workday == null
                                      ? "--:--"
                                      : "${DateTime.now().toString().substring(0, 10)} ${DateTime.now().hour < 10 ? "0${DateTime.now().hour}" : DateTime.now().hour}:${DateTime.now().minute < 10 ? "0${DateTime.now().minute}" : DateTime.now().minute}")
                              .applyDefaults(Theme.of(context).inputDecorationTheme),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Кол-во изготовленной продукции",
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          onChanged: (value) {
                            if (value.isEmpty) {
                              return;
                            }

                            setState(() {
                              productCount = double.parse(value);
                            });
                          },
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: const InputDecoration(
                            hintText: "0",
                          ).applyDefaults(Theme.of(context).inputDecorationTheme),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.card,
                                  width: 0.4,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: const Column(
                                children: [
                                  Icon(
                                    Iconsax.box,
                                    color: AppColors.text,
                                    size: 50,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "3",
                                    style: TextStyle(
                                      color: AppColors.text,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.card,
                                  width: 0.4,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.local_drink_sharp,
                                    color: AppColors.text,
                                    size: 50,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${productCount - boxCount * 50 < 0 ? 0 : productCount - 150}"
                                        .split(".")[0],
                                    style: const TextStyle(
                                      color: AppColors.text,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BasicButton(
                      isLoading: state is WorkdayLoadingState,
                      onPressed: () {
                        createReport(ReportModel(id: const Uuid().v4(), count: productCount));
                      },
                      text: "Отправить отчёт",
                    )
                  ],
                ),
              ),
            ],
          );
        });
      },
    );
  }
}
