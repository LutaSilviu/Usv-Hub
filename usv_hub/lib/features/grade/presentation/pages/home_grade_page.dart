import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/core/utils/custom_snackbar.dart';
import 'package:usv_hub/features/attendance/presentation/widgets/custom_course_widget.dart';
import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';
import 'package:usv_hub/features/grade/domain/entities/grade_entity.dart';
import 'package:usv_hub/features/grade/presentation/cubit/grade_cubit.dart';

class HomeGradePage extends StatefulWidget {
  const HomeGradePage({super.key});

  @override
  State<HomeGradePage> createState() => _HomeGradePageState();
}

class _HomeGradePageState extends State<HomeGradePage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<GradeCubit>().getCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppTextConst.selectCourse,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  filled: true,
                  prefixIconColor: Theme.of(context).colorScheme.primaryFixed,
                  fillColor: Theme.of(context).colorScheme.primaryContainer,
                  hintText: AppTextConst.search,
                  prefixIcon: const Icon(Icons.search),
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primaryFixed,
                      ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppTextConst.courses,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            BlocConsumer<GradeCubit, GradeState>(
              listener: (context, state) {
                if (state is ErrorState) {
                  CustomSnackbar.show(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is LoadingState) {
                  return const CircularProgressIndicator();
                }
                if (state is ErrorState) {
                  return const Center(
                    child: Text("Ups!,there is nothing here to see!"),
                  );
                }
                if (state is CoursesLoadedState) {
                  return Expanded(
                    child: GridView.builder(
                      itemCount: state.mapCoursesGrades.length,
                      itemBuilder: (context, index) {
                        CourseEntity course =
                            state.mapCoursesGrades.values.elementAt(index);
                        GradeEntity grade =
                            state.mapCoursesGrades.keys.elementAt(index);
                        return CustomCourseWidget(
                          image: AppImages.image1,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRouteConst.gradeDetailPage,
                              arguments: {
                                AppArguments.gradeEntity: grade,
                                AppArguments.courseEntity: course,
                              },
                            );
                          },
                          title: course.title,
                          semester: course.semester,
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
                return const Center(
                  child: Text("Ups!,there is nothing here to see!"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
