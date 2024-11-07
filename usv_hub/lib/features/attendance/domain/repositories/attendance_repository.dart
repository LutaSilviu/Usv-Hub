import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/attendance/domain/entities/attendance_entity.dart';

abstract class AttendanceRepository {
  Future<Either<Failure, void>> addAttendance(
      AttendanceEntity attendanceEntity);
  Future<Either<Failure, AttendanceEntity>> getAttendanceForStudent(
      String studentId, String courseId);
}
