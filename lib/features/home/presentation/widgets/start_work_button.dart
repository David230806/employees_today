import 'package:employees_today/core/configs/theme/app_colors.dart';
import 'package:employees_today/features/home/data/models/realtime_workday.dart';
import 'package:employees_today/features/home/domain/enum/working_status.dart';
import 'package:flutter/material.dart';

class StartWorkButton extends StatefulWidget {
  const StartWorkButton({super.key, required this.workday});

  final RealtimeWorkdayModel workday;

  @override
  State<StartWorkButton> createState() => _StartWorkButtonState();
}

class _StartWorkButtonState extends State<StartWorkButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: widget.workday.status == EWorkingStatus.online ? AppColors.assent : AppColors.grey,
          width: 4,
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.touch_app_outlined,
                  color: AppColors.text,
                  size: 46,
                ),
                const SizedBox(
                  height: 10,
                ),
                if (widget.workday.isWorkdayEnded == false)
                  Text(
                    widget.workday.status == EWorkingStatus.online
                        ? "Закончить работу"
                        : "Начать работу",
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 18,
                    ),
                  ),
                if (widget.workday.isWorkdayEnded == true)
                  const Text(
                    "День закончен",
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 18,
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
