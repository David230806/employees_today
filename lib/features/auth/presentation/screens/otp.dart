import 'package:employees_today/core/common/helpers/snackbar_controller.dart';
import 'package:employees_today/core/configs/assets/app_images.dart';
import 'package:employees_today/core/configs/theme/app_colors.dart';
import 'package:employees_today/core/widgets/base_button.dart';
import 'package:employees_today/core/widgets/otp_form.dart';
import 'package:employees_today/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpScreen extends StatelessWidget {
  final String verificationId;
  final String phoneNumber;
  final TextEditingController _otpController = TextEditingController();

  OtpScreen({super.key, required this.phoneNumber, required this.verificationId});

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
                OtpForm(
                  controller: _otpController,
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is SignInFailedState) {
                      context.snackbarController.showErrorSnackBar(state.error);
                    }

                    if (state is SignInSuccessState) {
                      context.snackbarController.showSuccessSnackbar('Success');
                    }
                  },
                  builder: (context, state) {
                    return BasicButton(
                      onPressed: () {
                        print(_otpController.text);
                        context.read<AuthBloc>().add(
                              SignInEvent(
                                verificationId: verificationId,
                                otpCode: _otpController.text,
                              ),
                            );
                      },
                      text: "Войти",
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

  Widget _authText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Верификация',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 34,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "Код верификации был отправлен на номер +$phoneNumber",
          style: const TextStyle(
            color: AppColors.grey,
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
