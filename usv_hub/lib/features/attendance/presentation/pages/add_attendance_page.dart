import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/attendance/presentation/providers/add_attendance_provider.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';

import 'package:usv_hub/features/grade/presentation/pages/grade_detail_page.dart';
import 'package:usv_hub/features/login/presentation/widgets/custom_elevated_button.dart';
import 'package:usv_hub/injection.dart';

class AddAttandancePage extends StatefulWidget {
  const AddAttandancePage({
    required this.student,
    required this.isTeacher,
    required this.courseId,
    required this.courseLenght,
    super.key,
  });

  final UserEntity student;
  final ProfesorType isTeacher;
  final String courseId;
  final int courseLenght;

  @override
  State<AddAttandancePage> createState() => _AddAttandancePageState();
}

class _AddAttandancePageState extends State<AddAttandancePage> {
  final String title = AppTextConst.addAttandancePage;
  final TextEditingController labController = TextEditingController();
  final TextEditingController courseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Background(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<AddAttendanceProvider>(
                create: (_) => getIt<AddAttendanceProvider>()),
          ],
          child: Builder(builder: (context) {
            return FutureBuilder(
              future: Provider.of<AddAttendanceProvider>(context, listen: false)
                  .getAttendance(widget.student.id, widget.courseId, context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                return Column(
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
                        title,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                    ),
                    SizedBox(height: 68.h),
                    DetailWidget(
                        title: "Student name: ${widget.student.name}",
                        height: 30.h),
                    DetailWidget(
                        title: "Student email: ${widget.student.email}",
                        height: 30.h),
                    DetailWidget(
                        title:
                            "Student phone number: ${widget.student.phoneNumber}",
                        height: 30.h),
                    Consumer<AddAttendanceProvider>(
                      builder: (BuildContext context,
                          AddAttendanceProvider value, Widget? child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.isTeacher != ProfesorType.teacher)
                              EnterAttandanceWidget(
                                labController: labController,
                                title: AppTextConst.labAttendance,
                                courseLenght: widget.courseLenght,
                                listOfAttendancesCourse:
                                    value.listOfAttendancesLaboratory,
                                selectedNumber: value.selectedLab,
                                onPressed: (int index) {
                                  value.selectedLab = index;
                                },
                                onSet: (AttendanceStatus attendanceStatus) {
                                  if (attendanceStatus ==
                                      AttendanceStatus.empty) {
                                    value.removeAttendanceCourse();
                                  } else {
                                    value.setAttendanceLab(attendanceStatus);
                                  }
                                },
                              ),
                            if (widget.isTeacher != ProfesorType.assistent)
                              EnterAttandanceWidget(
                                labController: courseController,
                                title: AppTextConst.courseAttandance,
                                courseLenght: widget.courseLenght,
                                listOfAttendancesCourse:
                                    value.listOfAttendancesCourse,
                                selectedNumber: value.selectedCourse,
                                onPressed: (int index) {
                                  value.selectedCourse = index;
                                },
                                onSet: (AttendanceStatus attendanceStatus) {
                                  if (attendanceStatus ==
                                      AttendanceStatus.empty) {
                                    value.removeAttendanceCourse();
                                  } else {
                                    value.setAttendanceCourse(attendanceStatus);
                                  }
                                },
                              ),
                            Center(
                                child: CustomElevatedButton(
                                    onPressed: () {
                                      Provider.of<AddAttendanceProvider>(
                                              context,
                                              listen: false)
                                          .addAttendance(widget.student.id,
                                              widget.courseId, context);
                                    },
                                    text: AppTextConst.add)),
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            );
          }),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class EnterAttandanceWidget extends StatelessWidget {
  EnterAttandanceWidget({
    super.key,
    required this.labController,
    required this.title,
    required this.courseLenght,
    required this.listOfAttendancesCourse,
    required this.selectedNumber,
    required this.onPressed,
    required this.onSet,
  });

  final TextEditingController labController;
  final String title;
  final int courseLenght;
  final Map<int, AttendanceStatus> listOfAttendancesCourse;
  int selectedNumber;
  Function(int) onPressed;
  Function(AttendanceStatus) onSet;

  @override
  Widget build(BuildContext context) {
    AttendanceStatus _selectedAttendance = AttendanceStatus.empty;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.surface,
                ),
          ),
          SizedBox(
            width: 900.w,
            height: 50.h,
            child: ListView.builder(
              itemCount: courseLenght,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                Color color;
                AttendanceStatus? attendanceStatus;
                if (listOfAttendancesCourse.containsKey(index + 1)) {
                  attendanceStatus = listOfAttendancesCourse.entries
                      .firstWhere((element) => element.key == index + 1)
                      .value;
                }
                if (attendanceStatus == null) {
                  color = AppColors.attendanceEmpty;
                } else {
                  if (attendanceStatus == AttendanceStatus.present) {
                    color = AppColors.attendancePresent;
                  } else {
                    color = AppColors.attendanceAbsent;
                  }
                }

                return Padding(
                  padding: EdgeInsets.all(5.w),
                  child: GestureDetector(
                    onTap: () {
                      onPressed(index + 1);
                    },
                    child: Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: color,
                        border: index + 1 == selectedNumber
                            ? Border.all(
                                color: Colors.black, // Culoarea conturului
                                width: 2, // Grosimea conturului
                              )
                            : null,
                        borderRadius: BorderRadius.circular(
                            8), // Opțional: colțuri rotunjite
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 120.w, // Dimensiune mică pentru dropdown
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white, // Fundal alb
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: DropdownButtonFormField<AttendanceStatus>(
                  decoration: const InputDecoration(
                    border: InputBorder.none, // Elimină bordura implicită
                    isDense: true, // Reduce spațiul pentru a fi mai compact
                  ),
                  value: _selectedAttendance,
                  icon: const Icon(Icons.arrow_drop_down,
                      color: Colors.grey), // Iconiță
                  items: AttendanceStatus.values.map((AttendanceStatus number) {
                    return DropdownMenuItem<AttendanceStatus>(
                      value: number,
                      child: Text(
                        number.stringValue.toString(),
                        style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (AttendanceStatus? newValue) {
                    _selectedAttendance = newValue!;
                    log(_selectedAttendance.toString());
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.surface)),
                onPressed: () {
                  onSet(_selectedAttendance);
                },
                child: Text(
                  "Set",
                  style: Theme.of(context).textTheme.bodySmall,
                  softWrap: true,
                ),
              ),
            ],
          ),

          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       Container(
          //         width: 100.w, // Dimensiune mică pentru dropdown
          //         padding: const EdgeInsets.symmetric(horizontal: 10),
          //         decoration: BoxDecoration(
          //           color: Colors.white, // Fundal alb
          //           borderRadius: BorderRadius.circular(8),
          //           border: Border.all(color: Colors.grey),
          //         ),
          //         child: DropdownButtonFormField<int>(
          //           decoration: const InputDecoration(
          //             border: InputBorder.none, // Elimină bordura implicită
          //             isDense: true, // Reduce spațiul pentru a fi mai compact
          //           ),
          //           value: _selectedNumber,
          //           icon: const Icon(Icons.arrow_drop_down,
          //               color: Colors.grey), // Iconiță
          //           items: _numbers.map((int number) {
          //             return DropdownMenuItem<int>(
          //               value: number,
          //               child: Text(
          //                 number.toString(),
          //                 style: const TextStyle(
          //                   color: AppColors.black,
          //                   fontSize: 14,
          //                 ), // Font mic
          //               ),
          //             );
          //           }).toList(),
          //           onChanged: (int? newValue) {
          //             _selectedNumber = newValue!;
          //           },
          //         ),
          //       ),
          //       Container(
          //         width: 120.w, // Dimensiune mică pentru dropdown
          //         padding: const EdgeInsets.symmetric(horizontal: 10),
          //         decoration: BoxDecoration(
          //           color: Colors.white, // Fundal alb
          //           borderRadius: BorderRadius.circular(8),
          //           border: Border.all(color: Colors.grey),
          //         ),
          //         child: DropdownButtonFormField<AttendanceStatus>(
          //           decoration: const InputDecoration(
          //             border: InputBorder.none, // Elimină bordura implicită
          //             isDense: true, // Reduce spațiul pentru a fi mai compact
          //           ),
          //           value: _selectedAttendance,
          //           icon: const Icon(Icons.arrow_drop_down,
          //               color: Colors.grey), // Iconiță
          //           items: AttendanceStatus.values.map((AttendanceStatus number) {
          //             return DropdownMenuItem<AttendanceStatus>(
          //               value: number,
          //               child: Text(
          //                 number.stringValue.toString(),
          //                 style: const TextStyle(
          //                   color: AppColors.black,
          //                   fontSize: 14,
          //                 ), // Font mic
          //               ),
          //             );
          //           }).toList(),
          //           onChanged: (AttendanceStatus? newValue) {
          //             _selectedAttendance = newValue!;
          //             log(_selectedAttendance.toString());
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
        ],
      ),
    );
  }
}
