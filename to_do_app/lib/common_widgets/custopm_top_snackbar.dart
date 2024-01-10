import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/resource/app_colors.dart';

class CustomSnackBar {
  static void show({required BuildContext context, required String message}) {
    Flushbar(
      backgroundGradient: const LinearGradient(
        colors: [AppColors.secondaryColor, AppColors.secondaryBackgroundColor],
      ),
      flushbarPosition: FlushbarPosition.TOP,

      backgroundColor: Colors.grey,
      message: message, // Use the dynamic message here

      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
