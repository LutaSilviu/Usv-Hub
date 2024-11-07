import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/attendance/presentation/cubit/attendance_cubit.dart';
import 'package:usv_hub/features/attendance/presentation/widgets/custom_course_widget.dart';
import 'package:usv_hub/features/attendance/presentation/widgets/custom_search_field.dart';
import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';
import 'package:usv_hub/features/login/presentation/providers/user_provider.dart';
import 'package:usv_hub/injection.dart';

class HomeAttendancePage extends StatefulWidget {
  const HomeAttendancePage({super.key});

  @override
  State<HomeAttendancePage> createState() => _HomeAttendancePageState();
}

class _HomeAttendancePageState extends State<HomeAttendancePage> {
  TextEditingController searchController = TextEditingController();

  AttendanceCubit loadData() {
    final selectedType = context.read<UserProvider>().selectedType;
    if (selectedType == SelectedType.student) {
      return getIt<AttendanceCubit>()..getAttendance();
    } else {
      return getIt<AttendanceCubit>()..getCoursesForTeacher();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: BlocProvider(
        create: (context) => loadData(),
        child: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSearchField(searchController: searchController),
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Courses',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              StudentList(),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentList extends StatelessWidget {
  const StudentList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceCubit, AttendanceState>(
      builder: (BuildContext context, AttendanceState state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is AttendanceError) {
          return Center(child: Text(state.errorMessage));
        }
        if (state is AttendanceLoaded) {
          if (state.attendanceAndCourses.isEmpty) {
            return const Center(child: Text(AppErrorMessages.noCoursesFound));
          }
          return Expanded(
            child: GridView.builder(
              itemCount: state.attendanceAndCourses.length,
              itemBuilder: (context, index) {
                return CustomCourseWidget(
                  image: AppImages.image1,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRouteConst.attendanceDetailPage,
                      arguments: {
                        AppArguments.attendanceEntity:
                            state.attendanceAndCourses.keys.elementAt(index),
                        AppArguments.courseEntity:
                            state.attendanceAndCourses.values.elementAt(index),
                      },
                    );
                  },
                  title:
                      state.attendanceAndCourses.values.elementAt(index).title,
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
              ),
            ),
          );
        }
        if (state is TeacherCoursesLoadedState) {
          if (state.mapCoursesGrades.isEmpty) {
            return const Center(child: Text(AppErrorMessages.noCoursesFound));
          }
          return Expanded(
            child: GridView.builder(
              itemCount: state.mapCoursesGrades.length,
              itemBuilder: (context, index) {
                ProfesorType isTeacher =
                    state.mapCoursesGrades.keys.elementAt(index);
                CourseEntity course =
                    state.mapCoursesGrades.values.elementAt(index);
                return CustomCourseWidget(
                  image: AppImages.image1,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRouteConst.viewStudents,
                      arguments: {
                        AppArguments.courseId: course.id,
                        AppArguments.isTeacher: isTeacher,
                        AppArguments.clickType: ClickType.attendance,
                        AppArguments.courseLenght: course.numberOfCourses,
                      },
                    );
                  },
                  title: state.mapCoursesGrades.values.elementAt(index).title,
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
              ),
            ),
          );
        }
        return const SizedBox(
          child: Center(
            child: Text(AppErrorMessages.ups),
          ),
        );
      },
    );
  }
}
