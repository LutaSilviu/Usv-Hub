import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/attendance/presentation/cubit/attendance_cubit.dart';
import 'package:usv_hub/features/attendance/presentation/widgets/custom_course_widget.dart';
import 'package:usv_hub/features/attendance/presentation/widgets/custom_search_field.dart';

class HomeAttendancePage extends StatefulWidget {
  const HomeAttendancePage({super.key});

  @override
  State<HomeAttendancePage> createState() => _HomeAttendancePageState();
}

class _HomeAttendancePageState extends State<HomeAttendancePage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: Background(
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
            BlocBuilder(
              builder: (BuildContext context, state) {
                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is AttendanceError) {
                  return Center(child: Text(state.errorMessage));
                }
                if (state is AttendanceLoaded) {
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
                                AppArguments.attendanceEntity: state
                                    .attendanceAndCourses.keys
                                    .elementAt(index),
                              },
                            );
                          },
                          title: state.attendanceAndCourses.values
                              .elementAt(index)
                              .title,
                          semester: state.attendanceAndCourses.values
                              .elementAt(index)
                              .semester,
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
            ),
          ],
        ),
      ),
    );
  }
}
