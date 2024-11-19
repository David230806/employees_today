import 'package:employees_today/core/configs/theme/app_colors.dart';
import 'package:employees_today/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:employees_today/features/auth/presentation/screens/auth.dart';
import 'package:employees_today/features/home/presentation/screens/home.dart';
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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
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
