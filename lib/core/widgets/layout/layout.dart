import 'package:employees_today/core/cubits/cubit/layout_cubit.dart';
import 'package:employees_today/core/widgets/layout/bottom_bar.dart';
import 'package:employees_today/features/history/presentation/screens/history.dart';
import 'package:employees_today/features/home/presentation/screens/home.dart';
import 'package:employees_today/features/profile/presentation/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: context.watch<LayoutCubit>().state,
            children: [
              HomeScreen(),
              const HistoryScreen(),
              const ProfileScreen(),
            ],
          ),
          const Positioned(
            bottom: 0,
            child: CustomNavigationBar(),
          )
        ],
      ),
    );
  }
}
