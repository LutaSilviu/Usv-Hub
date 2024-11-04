import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';
import 'package:usv_hub/features/grade/domain/entities/grade_entity.dart';

class GradeDetailPage extends StatelessWidget {
  const GradeDetailPage({
    required this.grade,
    required this.course,
    super.key,
  });

  final String title = AppTextConst.gradeDetailPage;
  final GradeEntity grade;
  final CourseEntity course;
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
            DetailWidget(title: "Number of courses: ${course.numberOfCourses}"),
            DetailWidget(title: "Course credits: ${course.courseCredits}"),
            DetailWidget(
              title: grade.courseGrade != null
                  ? "Course grade: ${grade.courseGrade}"
                  : "Lab grade: No grade added yet",
            ),
            DetailWidget(
                title: grade.labGrade != null
                    ? "Lab grade: ${grade.labGrade}"
                    : "Lab grade: No grade added yet"),
            DetailWidget(
              title: grade.labGrade != null && grade.courseGrade != null
                  ? "Final Grade: ${(grade.courseGrade! + grade.labGrade!) / 2}"
                  : "Final Grade: No grade added yet",
            ),
            DetailWidget(
              title: grade.labGrade != null && grade.courseGrade != null
                  ? "Puncte nota: ${(grade.courseGrade! + grade.labGrade!) / 2 * course.courseCredits}"
                  : "Puncte nota:No grade added yet",
            ),
          ],
        ),
      ),
    );
  }
}

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    super.key,
    required this.title,
    this.height,
  });
  final String title;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 45.w, right: 25.w),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: height ?? 48.h,
          ),
        ],
      ),
    );
  }
}
