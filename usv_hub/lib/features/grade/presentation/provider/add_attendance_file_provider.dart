import 'dart:developer';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/attendance/domain/entities/attendance_entity.dart';
import 'package:usv_hub/features/attendance/domain/usecases/add_attandance.dart';
import 'package:usv_hub/features/attendance/domain/usecases/get_attendance_for_student.dart';
import 'package:usv_hub/features/attendance/domain/usecases/get_student_by_name.dart';
import 'package:usv_hub/features/grade/domain/usecases/get_student_grade.dart';

@injectable
class AddAttendanceFileProvider extends ChangeNotifier {
  File? file;
  AddAttandance addAttandance;
  bool isLoading = false;
  GetStudentByName getStudentAfterName;
  GetAttendanceForStudent getAttendanceForStudent;
  AddAttendanceFileProvider(this.addAttandance, this.getStudentAfterName,
      this.getAttendanceForStudent);

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'xlsx'],
    );

    if (result != null) {
      file = File(result.files.single.path!);
    }
  }

  Future<List<List<dynamic>>> readExcel(File file) async {
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    List<List<dynamic>> data = [];
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        data.add(row.map((cell) => cell?.value).toList());
      }
    }
    return data;
  }

  Future<bool> processExcel(File file, String courseId, bool courseList) async {
    isLoading = true;
    List<List<dynamic>> data = await readExcel(file);
    for (var i = 1; i < data.length; i++) {
      (await getStudentAfterName.call(
        params: data[i][0].toString(),
      ))
          .fold(
        (l) {
          isLoading = false;
          return false;
        },
        (student) async {
          (await getAttendanceForStudent.call(
                  params: GetStudentsParams(student.id, courseId)))
              .fold(
            (l) {
              isLoading = false;
              return false;
            },
            (attendance) async {
              Map<String, bool> attendanceMap = courseList
                  ? attendance.courseAttendance
                  : attendance.labortoryAttendance;
              for (int j = 1; j < data[i].length; j++) {
                var element = data[i][j];
                if (element.toString() == "P") {
                  attendanceMap.update(j.toString(), (value) => true,
                      ifAbsent: () => true);
                } else if (element.toString() == "A") {
                  attendanceMap.update(j.toString(), (value) => false,
                      ifAbsent: () => false);
                }
              }
              (await addAttandance.call(
                params: AttendanceEntity(
                  id: attendance.id,
                  courseId: courseId,
                  studentId: student.id,
                  courseAttendance:
                      courseList ? attendanceMap : attendance.courseAttendance,
                  labortoryAttendance: courseList
                      ? attendance.labortoryAttendance
                      : attendanceMap,
                ),
              ))
                  .fold(
                (l) {
                  isLoading = false;
                  return false;
                },
                (r) {
                  isLoading = false;
                  return true;
                },
              );
            },
          );
        },
      );
    }
    isLoading = false;
    return true;
  }
}
