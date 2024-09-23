import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/attendance/domain/entities/attendance_entity.dart';
import 'package:usv_hub/features/attendance/domain/repositories/attendance_repository.dart';
import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';

class GetAttendance extends Usecase<
    Either<Failure, Map<AttendanceEntity, CourseEntity>>, void> {
  final AttendanceRepository _repository;

  GetAttendance(this._repository);
  @override
  Future<Either<Failure, Map<AttendanceEntity, CourseEntity>>> call(
      {void params}) async {
    return _repository.getAttendance();
  }
}
