import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/attendance/domain/entities/attendance_entity.dart';
import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';

abstract class AttendanceRepository {
  Future<Either<Failure, Map<AttendanceEntity, CourseEntity>>> getAttendance();
}
