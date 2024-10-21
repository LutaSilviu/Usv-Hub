import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/features/assigments/domain/entities/assigment_entity.dart';
import 'package:usv_hub/features/grade/presentation/pages/grade_detail_page.dart';
import 'package:usv_hub/features/login/presentation/widgets/custom_elevated_button.dart';

class AssigmentInfoPage extends StatelessWidget {
  const AssigmentInfoPage({super.key, required this.assigmentEntity});
  final String title = 'Assigment Info Page';
  final AssigmentEntity assigmentEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 40.h,
                ),
              ),
            ),
            Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            SizedBox(height: 40.h),
            Expanded(
              child: SingleChildScrollView(
                child: DetailWidget(
                  title: assigmentEntity.description,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                    onPressed: () {},
                    text: 'Add Homework',
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                  ),
                  CustomElevatedButton(
                    onPressed: () {},
                    text: 'Submit',
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
