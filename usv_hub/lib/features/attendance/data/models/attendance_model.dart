import 'dart:convert';

import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/attendance/domain/entities/attendance_entity.dart';

class AttendanceModel extends AttendanceEntity {
  const AttendanceModel({
    required super.id,
    required super.courseId,
    required super.studentId,
    required super.courseAttendance,
    required super.labortoryAttendance,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      AppFields.id: id,
      AppFields.courseId: courseId,
      AppFields.studentId: studentId,
      AppFields.courseAttendance: courseAttendance,
      AppFields.labortoryAttendance: labortoryAttendance,
    };
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      id: map[AppFields.id] as String,
      courseId: map[AppFields.courseId] as String,
      studentId: map[AppFields.studentId] as String,
      courseAttendance: Map<String, bool>.from(
          (map[AppFields.courseAttendance] as Map<String, dynamic>)),
      labortoryAttendance: Map<String, bool>.from(
          (map[AppFields.labortoryAttendance] as Map<String, dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceModel.fromJson(String source) =>
      AttendanceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  copyWith(String id) {
    return AttendanceModel(
      id: id,
      courseId: courseId,
      studentId: studentId,
      courseAttendance: courseAttendance,
      labortoryAttendance: labortoryAttendance,
    );
  }
}
