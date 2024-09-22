import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color,
  });
  final void Function()? onPressed;
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 40),
        backgroundColor:
            color ?? Theme.of(context).colorScheme.primaryContainer,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
