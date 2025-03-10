import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/core/utils/custom_snackbar.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';
import 'package:usv_hub/features/grade/presentation/cubit/grade_students/grade_students_cubit.dart';

class ViewStudents extends StatefulWidget {
  const ViewStudents({
    super.key,
    required this.courseId,
    required this.isTeacher,
    required this.clickType,
    this.courseLenght,
  });
  final String courseId;
  final ProfesorType isTeacher;
  final ClickType clickType;
  final int? courseLenght;

  @override
  State<ViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  TextEditingController searchController = TextEditingController();

  Future<void> loadData() async {
    await context.read<GradeStudentsCubit>().getStudents(widget.courseId);
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
          AppTextConst.viewStudents,
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
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //       vertical: 30.h, horizontal: 30.w),
                    //   child: TextField(
                    //     controller: searchController,
                    //     decoration: InputDecoration(
                    //       filled: true,
                    //       prefixIconColor:
                    //           Theme.of(context).colorScheme.primaryFixed,
                    //       fillColor:
                    //           Theme.of(context).colorScheme.primaryContainer,
                    //       hintText: AppTextConst.search,
                    //       prefixIcon: const Icon(Icons.search),
                    //       hintStyle: Theme.of(context)
                    //           .textTheme
                    //           .bodyMedium!
                    //           .copyWith(
                    //             color:
                    //                 Theme.of(context).colorScheme.primaryFixed,
                    //           ),
                    //       border: OutlineInputBorder(
                    //         borderSide: BorderSide.none,
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.all(20.w),
                    //   child: Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: Text(
                    //       AppTextConst.viewCoursesStudents,
                    //       style: Theme.of(context).textTheme.titleSmall,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 40.h,
                    ),
                    BlocConsumer<GradeStudentsCubit, GradeStudentsState>(
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
                        if (state is GradeStudentsLoaded) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: state.students.length,
                              itemBuilder: (context, index) {
                                UserEntity student = state.students[index];

                                return ListTile(
                                  leading: CircleAvatar(
                                    child: Icon(
                                      Icons.person,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryFixed,
                                    ),
                                  ),
                                  title: Text(student.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          )),
                                  subtitle: Text(student.email,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!),
                                  onTap: () {
                                    if (widget.clickType == ClickType.grade) {
                                      Navigator.pushNamed(
                                        context,
                                        AppRouteConst.addGrade,
                                        arguments: {
                                          AppArguments.isTeacher:
                                              widget.isTeacher,
                                          AppArguments.studentEntity: student,
                                          AppArguments.courseId:
                                              widget.courseId,
                                        },
                                      );
                                    } else if (widget.clickType ==
                                        ClickType.attendance) {
                                      Navigator.pushNamed(
                                        context,
                                        AppRouteConst.addAttandance,
                                        arguments: {
                                          AppArguments.isTeacher:
                                              widget.isTeacher,
                                          AppArguments.studentEntity: student,
                                          AppArguments.courseId:
                                              widget.courseId,
                                          AppArguments.courseLenght:
                                              widget.courseLenght,
                                        },
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          );
                        }
                        return const Center(
                          child: Text("Ups!,there is nothing here to see!"),
                        );
                      },
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}
