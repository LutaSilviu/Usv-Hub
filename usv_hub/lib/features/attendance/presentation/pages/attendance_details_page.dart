import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/attendance/domain/entities/attendance_entity.dart';
import 'package:usv_hub/features/attendance/presentation/cubit/attendance_cubit.dart';
import 'package:usv_hub/features/select_course/domain/entities/course_entity.dart';

class AttendanceDetailsPage extends StatelessWidget {
  const AttendanceDetailsPage({super.key, required this.course});

  final CourseEntity course;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Align(
          alignment: Alignment.topLeft,
          child: FutureBuilder(
              future: context.read<AttendanceCubit>().getAttendance(course.id),
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
                  return BlocBuilder<AttendanceCubit, AttendanceState>(
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is AttendanceError) {
                        return Center(
                          child: Text(state.errorMessage),
                        );
                      }
                      if (state is AttendanceLoaded) {
                        AttendanceEntity attendanceEntity = state.attendance;
                        final courseProcentage = (attendanceEntity
                                    .courseAttendance.values
                                    .where((element) => element == true)
                                    .length /
                                14) *
                            100;
                        final labProcentage = (attendanceEntity
                                    .labortoryAttendance.values
                                    .where((element) => element == true)
                                    .length /
                                14) *
                            100;
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 30.h, horizontal: 30.w),
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
                                  AppTextConst.attendanceDetail,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                ),
                              ),
                              SizedBox(height: 68.h),
                              Padding(
                                padding: EdgeInsets.only(left: 30.w),
                                child: Text(
                                  AppTextConst.courseAttandance,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 40.w,
                                  vertical: 40.h,
                                ),
                                child: GridView.builder(
                                  itemCount: course.numberOfCourses,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              course.numberOfCourses ~/ 2,
                                          crossAxisSpacing: 20.w,
                                          mainAxisSpacing: 20.h),
                                  itemBuilder: (context, index) {
                                    Color color;
                                    if (attendanceEntity.courseAttendance.keys
                                        .contains((index + 1).toString())) {
                                      if (attendanceEntity.courseAttendance[
                                          (index + 1).toString()]!) {
                                        color = AppColors.attendancePresent;
                                      } else {
                                        color = AppColors.attendanceAbsent;
                                      }
                                    } else {
                                      color = AppColors.attendanceEmpty;
                                    }
                                    return Container(
                                      width: 30.w,
                                      height: 30.h,
                                      color: color,
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 35.w),
                                child: Text(
                                  "Attendance procentage",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.h),
                                child: LinearPercentIndicator(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  trailing: Text(
                                    '${courseProcentage.round()}%',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  lineHeight: 20.h,
                                  percent: courseProcentage / 100,
                                  progressColor: AppColors.attendancePresent,
                                  backgroundColor: AppColors.attendanceAbsent,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 30.w),
                                child: Text(
                                  AppTextConst.labAttendance,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 40.w,
                                  vertical: 40.h,
                                ),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: course.numberOfCourses,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              course.numberOfCourses ~/ 2,
                                          crossAxisSpacing: 20.w,
                                          mainAxisSpacing: 20.h),
                                  itemBuilder: (context, index) {
                                    Color color;
                                    if (attendanceEntity
                                        .labortoryAttendance.keys
                                        .contains((index + 1).toString())) {
                                      if (attendanceEntity.labortoryAttendance[
                                          (index + 1).toString()]!) {
                                        color = AppColors.attendancePresent;
                                      } else {
                                        color = AppColors.attendanceAbsent;
                                      }
                                    } else {
                                      color = AppColors.attendanceEmpty;
                                    }
                                    return Container(
                                      width: 30.w,
                                      height: 30.h,
                                      color: color,
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 35.w),
                                child: Text(
                                  "Attendance procentage",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.h),
                                child: LinearPercentIndicator(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  trailing: Text(
                                    '${labProcentage.round()}%',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  lineHeight: 20.h,
                                  percent: labProcentage / 100,
                                  progressColor: AppColors.attendancePresent,
                                  backgroundColor: AppColors.attendanceAbsent,
                                ),
                              ),
                              // SizedBox(height: 120.h),
                            ],
                          ),
                        );
                      }
                      return Container();
                    },
                  );
                }
                return Container();
              }),
        ),
      ),
    );
  }
}
