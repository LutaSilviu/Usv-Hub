import 'package:flutter/material.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/home/presentation/widgets/main_button.dart';
import 'package:usv_hub/features/select_course/domain/entities/course_entity.dart';

class HomePage extends StatelessWidget {
  const HomePage(
      {super.key, required this.courseEntity, required this.isTeacher});

  final CourseEntity courseEntity;
  final ProfesorType isTeacher;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTextConst.home),
        actions: [
          IconButton(
            style: Theme.of(context).iconButtonTheme.style!.copyWith(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Background(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 64.h,
              ),
              Image.asset(AppImages.usv),
              SizedBox(
                height: 30.h,
              ),
              Divider(
                color: Theme.of(context).colorScheme.secondaryContainer,
                indent: 32.w,
                endIndent: 32.w,
              ),
              SizedBox(
                height: 30.h,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MainButton(
                        title: AppTextConst.grade,
                        icon: Icons.grading_rounded,
                        onPressed: () {
                          if (!(isTeacher == ProfesorType.none)) {
                            Navigator.pushNamed(
                              context,
                              AppRouteConst.viewStudents,
                              arguments: {
                                AppArguments.courseId: courseEntity.id,
                                AppArguments.isTeacher: isTeacher,
                                AppArguments.clickType: ClickType.grade,
                                AppArguments.courseLenght:
                                    courseEntity.numberOfCourses,
                              },
                            );
                          } else {
                            Navigator.pushNamed(
                              context,
                              AppRouteConst.gradeDetailPage,
                              arguments: {
                                AppArguments.courseEntity: courseEntity,
                                AppArguments.isTeacher: isTeacher,
                              },
                            );
                          }
                        },
                      ),
                      MainButton(
                        title: AppTextConst.attendance,
                        icon: Icons.checklist,
                        onPressed: () {
                          if (isTeacher == ProfesorType.none) {
                            Navigator.pushNamed(
                              context,
                              AppRouteConst.attendanceDetailPage,
                              arguments: {
                                AppArguments.courseEntity: courseEntity,
                              },
                            );
                          } else {
                            Navigator.pushNamed(
                              context,
                              AppRouteConst.viewStudents,
                              arguments: {
                                AppArguments.courseId: courseEntity.id,
                                AppArguments.isTeacher: isTeacher,
                                AppArguments.clickType: ClickType.attendance,
                                AppArguments.courseLenght:
                                    courseEntity.numberOfCourses,
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 54.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MainButton(
                        title: AppTextConst.schedule,
                        icon: Icons.calendar_today,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRouteConst.schedule,
                          );
                        },
                      ),
                      MainButton(
                        title: AppTextConst.assigments,
                        icon: Icons.assignment_ind_outlined,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRouteConst.assignments,
                            arguments: {
                              AppArguments.courseEntity: courseEntity,
                              AppArguments.isTeacher: isTeacher,
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
