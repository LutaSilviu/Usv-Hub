import 'dart:convert';

import 'package:usv_hub/features/attendance/domain/entities/attendance_entity.dart';

class AttendanceModel extends AttendanceEntity {
  AttendanceModel({
    required super.id,
    required super.courseId,
    required super.studentId,
    required super.courseAttendance,
    required super.labortoryAttendance,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'courseId': courseId,
      'studentId': studentId,
      'courseAttendance': courseAttendance,
      'labortoryAttendance': labortoryAttendance,
    };
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      id: map['id'] as String,
      courseId: map['courseId'] as String,
      studentId: map['studentId'] as String,
      courseAttendance:
          Map<int, bool>.from((map['courseAttendance'] as Map<int, bool>)),
      labortoryAttendance:
          Map<int, bool>.from((map['labortoryAttendance'] as Map<int, bool>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceModel.fromJson(String source) =>
      AttendanceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
