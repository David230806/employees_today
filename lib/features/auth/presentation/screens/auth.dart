import 'package:employees_today/core/common/helpers/snackbar_controller.dart';
import 'package:employees_today/core/configs/assets/app_images.dart';
import 'package:employees_today/core/configs/theme/app_colors.dart';
import 'package:employees_today/core/widgets/base_button.dart';
import 'package:employees_today/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:employees_today/features/auth/presentation/screens/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: Image.asset(
                AppImages.auth,
                width: 300,
                height: 350,
                fit: BoxFit.fitHeight,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                _authText(),
                const SizedBox(
                  height: 50,
                ),
                _phoneTextField(context),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is VerifyNumberSuccessState) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => OtpScreen(
                            phoneNumber: _phoneController.text,
                            verificationId: state.verificationId,
                          ),
                        ),
                      );
                    }

                    if (state is VerifyNumberFailedState) {
                      context.snackbarController.showErrorSnackBar(state.error);
                    }
                  },
                  builder: (context, state) {
                    return BasicButton(
                      isLoading: state is VerifyNumberLoadingState,
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              VerifyNumberEvent(number: _phoneController.text),
                            );
                      },
                      text: "Продолжить",
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _phoneTextField(BuildContext context) {
    return TextField(
      controller: _phoneController,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(hintText: "Номер телефона")
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _authText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Войти',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 34,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "На ваш номер телефона придёт код верификации",
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
