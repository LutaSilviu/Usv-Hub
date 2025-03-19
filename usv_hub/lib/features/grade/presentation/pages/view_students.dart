import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/core/utils/custom_snackbar.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';
import 'package:usv_hub/features/grade/presentation/cubit/grade_students/grade_students_cubit.dart';
import 'package:usv_hub/features/grade/presentation/provider/add_attendance_file_provider.dart';
import 'package:usv_hub/injection.dart';

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
    return ChangeNotifierProvider(
      create: (context) => getIt<AddAttendanceFileProvider>(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            AppTextConst.viewStudents,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        floatingActionButton: widget.clickType == ClickType.attendance
            ? Consumer(
                builder: (context, AddAttendanceFileProvider provider, child) {
                  return FloatingActionMenu(
                    onSelected: (bool courseList) async {
                      await provider.pickFile();
                      if (provider.file != null) {
                        if (provider.file!.path.endsWith('.csv')) {
                          // await provider.processCsv(provider.file!);
                        } else if (provider.file!.path.endsWith('.xlsx')) {
                          final status = await provider.processExcel(
                              provider.file!, widget.courseId, courseList);
                          if (status) {
                            if (context.mounted) {
                              CustomSnackbar.show(context, "Success");
                            }
                          } else {
                            if (context.mounted) {
                              CustomSnackbar.show(context, "Error");
                            }
                          }
                        } else {
                          if (context.mounted) {
                            CustomSnackbar.show(context, "Invalid file format");
                          }
                        }
                      }
                    },
                  );
                },
              )
            : null,
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
                  if (Provider.of<AddAttendanceFileProvider>(context)
                      .isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
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
      ),
    );
  }
}

class FloatingActionMenu extends StatefulWidget {
  const FloatingActionMenu({super.key, required this.onSelected});
  @override
  FloatingActionMenuState createState() => FloatingActionMenuState();

  final Function(bool) onSelected;
}

class FloatingActionMenuState extends State<FloatingActionMenu>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      activeChild: const Icon(Icons.close),
      animatedIconTheme: const IconThemeData(size: 22.0),
      // backgroundColor: Theme.of(context).colorScheme.primaryFixed,
      onOpen: () => log('OPENING DIAL'),
      onClose: () => log('DIAL CLOSED'),
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.school),
          backgroundColor: Theme.of(context).colorScheme.primaryFixed,
          label: 'Curs',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () async {
            await widget.onSelected(true);
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.science),
          backgroundColor: Theme.of(context).colorScheme.primaryFixed,
          label: 'Laborator',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () async {
            await widget.onSelected(false);
          },
        ),
      ],
      child: const Icon(Icons.add),
    );
  }
}
