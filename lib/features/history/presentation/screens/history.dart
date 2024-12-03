import 'package:employees_today/core/configs/theme/app_colors.dart';
import 'package:employees_today/core/widgets/calendar.dart';
import 'package:employees_today/core/widgets/scaffold_wrapper.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DecorationWrapper(
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
            ],
          ),
        ),
      ),
    );
  }
}
