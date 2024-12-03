import 'package:employees_today/core/configs/theme/app_colors.dart';
import 'package:employees_today/core/widgets/scaffold_wrapper.dart';
import 'package:employees_today/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DecorationWrapper(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: Center(
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is SignInSuccessState) {
                      return Text(
                        state.user.name + state.user.surname,
                        style: const TextStyle(
                          color: AppColors.text,
                          fontSize: 24,
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Column(
                children: [
                  _buildSettingsCard(
                    const Icon(
                      Iconsax.user,
                      color: AppColors.text,
                    ),
                    "Профиль",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildSettingsCard(
                    const Icon(
                      Iconsax.money,
                      color: AppColors.text,
                    ),
                    "Зарплата",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildSettingsCard(
                    const Icon(
                      Iconsax.chart,
                      color: AppColors.text,
                    ),
                    "Статистика",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(
    Icon icon,
    String title,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.assent,
            ),
            child: const Icon(
              Iconsax.arrow_right,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}
