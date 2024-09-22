import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primaryFixed,
            Theme.of(context).colorScheme.primary,
          ],
        ),
      ),
      child: child,
    );
  }
}
