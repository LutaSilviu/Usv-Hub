import 'package:flutter/material.dart';
import 'package:usv_hub/core/utils/consts.dart';

class CustomSnackbar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.grey.withAlpha(100),
        content: Text(message),
      ),
    );
  }
}
