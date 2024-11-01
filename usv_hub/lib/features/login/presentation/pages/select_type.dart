import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/login/presentation/providers/user_provider.dart';

class SelectType extends StatelessWidget {
  const SelectType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GradientIconButton(
                onPressed: () {
                  context.read<UserProvider>().selectType(SelectedType.student);
                  Navigator.pushNamed(context, AppRouteConst.login);
                },
                icon: Icons.person,
                size: MediaQuery.of(context).size.width * 0.5,
              ),
              GradientIconButton(
                onPressed: () {},
                icon: FontAwesomeIcons.chalkboardUser,
                isFirst: false,
                size: MediaQuery.of(context).size.width * 0.4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isFirst;
  final double size;

  const GradientIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.isFirst = true,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
            colors: isFirst
                ? [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primaryFixed,
                  ]
                : [
                    Theme.of(context).colorScheme.primaryFixed,
                    Theme.of(context).colorScheme.primary,
                  ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.6,
          maxHeight: MediaQuery.of(context).size.width * 0.6,
          minWidth: MediaQuery.of(context).size.width * 0.6,
          minHeight: MediaQuery.of(context).size.width * 0.6,
        ),
        child: Icon(
          icon,
          color: Colors.white, // Icon color
          size: size,
        ),
      ),
    );
  }
}
