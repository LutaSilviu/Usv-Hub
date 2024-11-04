import 'package:flutter/material.dart';

import 'package:usv_hub/core/utils/consts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword,
    this.keyboardType,
  });
  final String hintText;
  final TextEditingController controller;
  final bool? isPassword;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        obscureText: isPassword ?? false,
        keyboardType: keyboardType ?? TextInputType.emailAddress,
        controller: controller,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.black,
            ),
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.grey,
              ),
          fillColor: Theme.of(context).colorScheme.surface,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
