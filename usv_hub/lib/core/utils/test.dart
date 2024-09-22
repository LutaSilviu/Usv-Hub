import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'dart:math' as math;

class Test extends StatelessWidget {
  const Test({super.key});

  ///TODO: fix this image
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.hartaCampus),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
