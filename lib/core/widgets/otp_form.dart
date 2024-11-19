import 'dart:developer';

import 'package:employees_today/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpForm extends StatelessWidget {
  final TextEditingController controller;

  OtpForm({super.key, required this.controller});

  final List<String> otpCode = ["", "", "", "", "", ""];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 68,
            width: 50,
            child: TextFormField(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  otpCode[0] = value;
                  FocusScope.of(context).nextFocus();
                }

                if (value.isEmpty) {
                  otpCode[0] = "";
                  controller.text = otpCode.join();
                  FocusScope.of(context).previousFocus();
                }
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: "0",
                hintStyle: TextStyle(color: AppColors.grey),
                contentPadding: EdgeInsets.only(bottom: 20),
              ),
              onSaved: (newValue) {
                if (newValue != null) {
                  controller.text = newValue;
                }
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            height: 68,
            width: 50,
            child: TextFormField(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  otpCode[1] = value;
                  FocusScope.of(context).nextFocus();
                }

                if (value.isEmpty) {
                  otpCode[1] = "";
                  controller.text = otpCode.join();
                  FocusScope.of(context).previousFocus();
                }
              },
              onSaved: (newValue) {
                if (newValue != null) {
                  controller.text = newValue;
                }
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: "0",
                hintStyle: TextStyle(color: AppColors.grey),
                contentPadding: EdgeInsets.only(bottom: 20),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            height: 68,
            width: 50,
            child: TextFormField(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  otpCode[2] = value;
                  controller.text = otpCode.join();
                  FocusScope.of(context).nextFocus();
                }

                if (value.isEmpty) {
                  otpCode[2] = "";
                  FocusScope.of(context).previousFocus();
                }
              },
              onSaved: (newValue) {
                if (newValue != null) {
                  controller.text = newValue;
                }
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: "0",
                hintStyle: TextStyle(color: AppColors.grey),
                contentPadding: EdgeInsets.only(bottom: 20),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            height: 68,
            width: 50,
            child: TextFormField(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  otpCode[3] = value;
                  controller.text = otpCode.join();
                  FocusScope.of(context).nextFocus();
                }

                if (value.isEmpty) {
                  otpCode[3] = "";
                  FocusScope.of(context).previousFocus();
                }
              },
              onSaved: (newValue) {
                if (newValue != null) {
                  controller.text = newValue;
                }
              },
              decoration: const InputDecoration(
                hintText: "0",
                hintStyle: TextStyle(color: AppColors.grey),
                contentPadding: EdgeInsets.only(bottom: 20),
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            height: 68,
            width: 50,
            child: TextFormField(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  otpCode[4] = value;
                  controller.text = otpCode.join();
                  FocusScope.of(context).nextFocus();
                }

                if (value.isEmpty) {
                  otpCode[4] = "";
                  FocusScope.of(context).previousFocus();
                }
              },
              decoration: const InputDecoration(
                hintText: "0",
                hintStyle: TextStyle(color: AppColors.grey),
                contentPadding: EdgeInsets.only(bottom: 20),
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            height: 68,
            width: 50,
            child: TextFormField(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  otpCode[5] = value;
                  controller.text = otpCode.join();
                }

                if (value.isEmpty) {
                  otpCode[5] = "";
                  FocusScope.of(context).previousFocus();
                }
              },
              onSaved: (pin4) {
                log(pin4 ?? "empty");
              },
              decoration: const InputDecoration(
                hintText: "0",
                hintStyle: TextStyle(color: AppColors.grey),
                contentPadding: EdgeInsets.only(bottom: 20),
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
