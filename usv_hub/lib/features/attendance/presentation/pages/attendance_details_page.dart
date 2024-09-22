import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';

class AttendanceDetailsPage extends StatelessWidget {
  const AttendanceDetailsPage({super.key});
  final String title = 'Attendance Detail Page';
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
            SizedBox(height: 68.h),
            Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Text(
                "Course attendance:",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.w,
                  vertical: 40.h,
                ),
                child: GridView.builder(
                  itemCount: 14,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 20.h),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 30.w,
                      height: 30.h,
                      color: index % 2 == 0
                          ? AppColors.attendancePresent
                          : AppColors.attendanceAbsent,
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 35.w),
              child: Text(
                "Attendance procentage",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.h),
              child: LinearPercentIndicator(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                trailing: Text(
                  '85%',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                lineHeight: 20.h,
                percent: 0.85,
                progressColor: AppColors.attendancePresent,
                backgroundColor: AppColors.attendanceAbsent,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Text(
                "Course attendance:",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.w,
                  vertical: 40.h,
                ),
                child: GridView.builder(
                  itemCount: 14,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 20.h),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 30.w,
                      height: 30.h,
                      color: index % 2 == 0
                          ? AppColors.attendancePresent
                          : AppColors.attendanceAbsent,
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 35.w),
              child: Text(
                "Attendance procentage",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.h),
              child: LinearPercentIndicator(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                trailing: Text(
                  '85%',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                lineHeight: 20.h,
                percent: 0.85,
                progressColor: AppColors.attendancePresent,
                backgroundColor: AppColors.attendanceAbsent,
              ),
            ),
            SizedBox(height: 120.h),
          ],
        ),
      ),
    );
  }
}
