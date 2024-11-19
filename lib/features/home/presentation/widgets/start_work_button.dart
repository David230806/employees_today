import 'package:employees_today/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StartWorkButton extends StatefulWidget {
  const StartWorkButton({super.key});

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
          color: AppColors.assent,
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
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.touch_app_outlined,
                  color: AppColors.text,
                  size: 46,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Начать работу",
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
