import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/core/utils/custom_snackbar.dart';
import 'package:usv_hub/features/attendance/presentation/widgets/custom_course_widget.dart';
import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';
import 'package:usv_hub/features/grade/domain/entities/grade_entity.dart';
import 'package:usv_hub/features/grade/presentation/cubit/grade_courses/grade_cubit.dart';
import 'package:usv_hub/features/login/presentation/providers/user_provider.dart';

class HomeGradePage extends StatefulWidget {
  const HomeGradePage({super.key});

  @override
  State<HomeGradePage> createState() => _HomeGradePageState();
}

class _HomeGradePageState extends State<HomeGradePage> {
  TextEditingController searchController = TextEditingController();

  Future<void> loadData() async {
    final selectedType = context.read<UserProvider>().selectedType;
    if (selectedType == SelectedType.student) {
      await context.read<GradeCubit>().getCourses();
    } else {
      await context.read<GradeCubit>().getTeacherCourses();
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
        child: FutureBuilder(
            future: loadData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading spinner while data is being fetched
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Show an error message if fetching data fails
                return const Center(child: Text('Error loading courses'));
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 30.h, horizontal: 30.w),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          filled: true,
                          prefixIconColor:
                              Theme.of(context).colorScheme.primaryFixed,
                          fillColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          hintText: AppTextConst.search,
                          prefixIcon: const Icon(Icons.search),
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.primaryFixed,
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
                    const BodyWidget(),
                  ],
                );
              }
            }),
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GradeCubit, GradeState>(
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
          return Expanded(
            child: GridView.builder(
              itemCount: state.mapCoursesGrades.length,
              itemBuilder: (context, index) {
                CourseEntity course =
                    state.mapCoursesGrades.values.elementAt(index);
                ProfesorType isTeacher =
                    state.mapCoursesGrades.keys.elementAt(index);
                return CustomCourseWidget(
                  image: AppImages.image1,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRouteConst.viewStudents,
                      arguments: {
                        AppArguments.courseId: course.id,
                        AppArguments.isTeacher: isTeacher,
                        AppArguments.clickType: ClickType.grade,
                      },
                    );
                  },
                  title: course.title,
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
