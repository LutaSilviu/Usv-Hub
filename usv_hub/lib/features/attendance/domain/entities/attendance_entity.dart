import 'package:equatable/equatable.dart';

class AttendanceEntity extends Equatable {
  final String id;
  final String courseId;
  final String studentId;
  final Map<int, bool> courseAttendance;
  final Map<int, bool> labortoryAttendance;

  const AttendanceEntity({
    required this.id,
    required this.courseId,
    required this.studentId,
    required this.courseAttendance,
    required this.labortoryAttendance,
  });

  @override
  List<Object?> get props => [
        id,
        courseId,
        studentId,
        courseAttendance,
        labortoryAttendance,
      ];
}
