import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/grade/presentation/cubit/grade_courses/grade_cubit.dart';
import 'package:usv_hub/features/select_course/domain/entities/course_entity.dart';
import 'package:usv_hub/features/grade/domain/entities/grade_entity.dart';

class GradeDetailPage extends StatelessWidget {
  const GradeDetailPage({
    required this.course,
    super.key,
  });

  final String title = AppTextConst.gradeDetailPage;

  final CourseEntity course;
  @override
  Widget build(BuildContext context) {
    Future<void> getData() async {
      await context.read<GradeCubit>().getGrades(course.id);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTextConst.gradeDetailPage),
      ),
      body: Background(
        child: FutureBuilder(
            future: getData(),
            builder: (context, value) {
              if (value.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (value.hasError) {
                return Center(
                  child: Text(value.error.toString()),
                );
              }
              if (value.connectionState == ConnectionState.done) {
                return BlocBuilder<GradeCubit, GradeState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is ErrorState) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    if (state is GradeLoadedState) {
                      GradeEntity grade = state.grade;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: SizedBox(height: 68.h)),
                          DetailWidget(
                              title:
                                  "Number of courses: ${course.numberOfCourses}"),
                          DetailWidget(
                              title: "Course credits: ${course.courseCredits}"),
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
                            title: grade.labGrade != null &&
                                    grade.courseGrade != null
                                ? "Final Grade: ${(grade.courseGrade! + grade.labGrade!) / 2}"
                                : "Final Grade: No grade added yet",
                          ),
                          DetailWidget(
                            title: grade.labGrade != null &&
                                    grade.courseGrade != null
                                ? "Puncte nota: ${(grade.courseGrade! + grade.labGrade!) / 2 * course.courseCredits}"
                                : "Puncte nota:No grade added yet",
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                );
              }
              return Container();
            }),
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
