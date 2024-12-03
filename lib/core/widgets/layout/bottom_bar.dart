import 'package:employees_today/core/configs/theme/app_colors.dart';
import 'package:employees_today/core/cubits/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 36,
      height: 70,
      margin: const EdgeInsets.all(16.0), // Space around the navbar
      // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Inside padding
      decoration: BoxDecoration(
        color: AppColors.assent,
        borderRadius: BorderRadius.circular(30), // Rounded edges
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2), // Subtle shadow effect
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(context, Iconsax.home, "Главная", true, 0),
          _buildNavItem(context, Iconsax.story, "История", false, 1),
          _buildNavItem(context, Iconsax.user, "Профиль", false, 2),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    bool isSelected,
    int index,
  ) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: context.watch<LayoutCubit>().state == index ? AppColors.primary : AppColors.assent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        onTap: () {
          context.read<LayoutCubit>().changeIndex(index);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: context.watch<LayoutCubit>().state == index ? Colors.white : Colors.white70,
              size: 28,
            ),
            const SizedBox(
              width: 10,
            ),
            if (context.watch<LayoutCubit>().state == index)
              Animate(
                effects: [
                  FadeEffect(
                    duration: 400.ms,
                  ),
                  SlideEffect(
                    begin: const Offset(-0.5, 0),
                    end: const Offset(0, 0),
                    duration: 200.ms,
                  ),
                ],
                child: Text(
                  label,
                  style: TextStyle(
                    color:
                        context.watch<LayoutCubit>().state == index ? Colors.white : Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
