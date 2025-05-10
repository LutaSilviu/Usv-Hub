import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/attendance/presentation/widgets/custom_course_widget.dart';
import 'package:usv_hub/features/select_course/domain/entities/course_entity.dart';
import 'package:usv_hub/features/login/presentation/providers/user_provider.dart';
import 'package:usv_hub/features/select_course/presentation/cubit/select_course_cubit.dart';
import 'package:usv_hub/injection.dart';

class SelectCoursePage extends StatefulWidget {
  const SelectCoursePage({super.key});

  @override
  State<SelectCoursePage> createState() => _SelectCoursePageState();
}

class _SelectCoursePageState extends State<SelectCoursePage> {
  TextEditingController searchController = TextEditingController();
  SelectCourseCubit getData(bool isTeacher) {
    return getIt<SelectCourseCubit>()..getCourses(isTeacher);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTextConst.selectCourse),
        leading: IconButton(
          style: Theme.of(context).iconButtonTheme.style!.copyWith(
                backgroundColor: WidgetStateProperty.all<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
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
        child: Consumer<UserProvider>(
          builder:
              (BuildContext context, UserProvider provider, Widget? child) {
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (provider.user == null) {
              return const Center(
                child: Text('No user found'),
              );
            }
            return BlocProvider(
              create: (context) =>
                  getData(provider.selectedType == SelectedType.teacher),
              child: Column(
                children: [
                  //CustomSearchField(searchController: searchController),
                  SizedBox(
                    height: 40.h,
                  ),
                  BlocBuilder<SelectCourseCubit, SelectCourseState>(
                    builder: (context, state) {
                      if (state is CoursesLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is CoursesError) {
                        return Text(state.message);
                      }
                      if (state is CoursesLoaded) {
                        return Expanded(
                          child: GridView.builder(
                            itemCount: state.courses.length,
                            itemBuilder: (context, index) {
                              ProfesorType isTeacher =
                                  state.courses.elementAt(index).keys.first;
                              CourseEntity course =
                                  state.courses.elementAt(index).values.first;
                              return CustomCourseWidget(
                                image: AppImages.image1,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRouteConst.home,
                                    arguments: {
                                      AppArguments.courseEntity: course,
                                      AppArguments.isTeacher: isTeacher,
                                    },
                                  );
                                },
                                title: state.courses
                                    .elementAt(index)
                                    .values
                                    .first
                                    .title,
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
                      return Container();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
