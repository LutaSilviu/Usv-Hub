import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  ///TODO: fix this image
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Background(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: PhotoView(
                imageProvider: const AssetImage(AppImages.hartaCampus)),
          ),
        ),
      ),
    );
  }
}
