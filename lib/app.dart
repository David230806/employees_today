import 'package:employees_today/core/configs/theme/app_themes.dart';
import 'package:employees_today/core/widgets/loading_screen.dart';
import 'package:employees_today/dependency_injection.dart';
import 'package:employees_today/features/auth/domain/repositories/auth_repository.dart';
import 'package:employees_today/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(sl<AuthRepository>()),
      child: MaterialApp(
        theme: AppThemes.primaryTheme,
        debugShowCheckedModeBanner: false,
        home: const LoadingScreen(),
      ),
    );
  }
}
