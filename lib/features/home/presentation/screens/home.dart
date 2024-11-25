import 'package:employees_today/core/common/helpers/month_title.dart';
import 'package:employees_today/core/common/helpers/week_day_title.dart';
import 'package:employees_today/core/configs/theme/app_colors.dart';
import 'package:employees_today/core/widgets/charts/bar_chart.dart';
import 'package:employees_today/core/widgets/charts/pie_chart.dart';
import 'package:employees_today/core/widgets/scaffold_wrapper.dart';
import 'package:employees_today/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:employees_today/features/home/presentation/widgets/start_work_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              _buildStartWorkContainer(),
              const SizedBox(
                height: 10,
              ),
              _buildTimeStatContainer(),
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

  Widget _buildTimeStatContainer() {
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
          const Column(
            children: [
              Icon(
                Icons.timelapse_rounded,
                color: Colors.teal,
              ),
              Text(
                "09:00",
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.text,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
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
              const Text(
                "18:00",
                style: TextStyle(
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
          const Column(
            children: [
              Icon(
                Icons.access_time_rounded,
                color: AppColors.assent,
              ),
              Text(
                "08:00",
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.text,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Рабочии часы",
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

  Widget _buildStartWorkContainer() {
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
          const StartWorkButton(),
          const Spacer(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.location,
                color: AppColors.text,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Локация: Не в офисе",
                style: TextStyle(
                  color: AppColors.text,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
