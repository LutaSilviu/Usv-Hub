import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
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
            Expanded(
              child: GridView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CustomCourseWidget(
                    image: AppImages.image1,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRouteConst.attendanceDetailPage,
                      );
                    },
                    title: 'Course $index',
                    semester: 'Semester $index',
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
