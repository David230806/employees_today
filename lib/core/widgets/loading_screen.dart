import 'dart:developer';

import 'package:employees_today/core/configs/theme/app_colors.dart';
import 'package:employees_today/core/widgets/layout/layout.dart';
import 'package:employees_today/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:employees_today/features/auth/presentation/screens/auth.dart';
import 'package:employees_today/features/home/presentation/bloc/realtime_workday/realtime_workday_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignInSuccessState) {
            log("State used id: ${state.user.id}");
            context.read<RealtimeWorkdayBloc>().setUserId(state.user.id);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Layout(),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AuthScreen(),
              ),
            );
          }
        },
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
