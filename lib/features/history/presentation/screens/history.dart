import 'package:employees_today/core/configs/theme/app_colors.dart';
import 'package:employees_today/core/widgets/calendar.dart';
import 'package:employees_today/core/widgets/scaffold_wrapper.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecorationWrapper(
      child: Column(
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
    );
  }
}
