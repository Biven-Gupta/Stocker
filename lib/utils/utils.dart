import 'dart:developer';

import 'package:flutter/material.dart';

class Utils {
  static void showValidationToast(BuildContext context, String? message) {
    log("Toast message: ${message ?? "NULL"}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message ?? "Something went wrong",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void showSuccessToast(BuildContext context, String? message) {
    log("Toast message: ${message ?? "NULL"}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message ?? "Something went wrong",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void showErrorToast(BuildContext context, {String? message}) {
    log("Error toast message: ${message ?? "NULL"}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message ?? "Something went wrong",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
