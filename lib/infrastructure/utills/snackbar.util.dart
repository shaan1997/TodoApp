import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarUtil {
  static void showSuccess({ String message}) {
    Get.rawSnackbar(
      title: 'Success',
      message: message,
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.green.shade600,
    );
  }

  static void showWarning({ String message}) {
    Get.rawSnackbar(
      title: 'Warning',
      message: message,
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.orange.shade900,
    );
  }

  static void showError({ String message}) {
    Get.rawSnackbar(
      title: 'Error',
      message: message,
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.redAccent.shade700,
    );
  }
}