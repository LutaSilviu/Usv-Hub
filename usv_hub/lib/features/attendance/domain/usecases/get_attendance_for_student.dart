import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/attendance/domain/entities/attendance_entity.dart';
import 'package:usv_hub/features/attendance/domain/repositories/attendance_repository.dart';

import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/grade/domain/usecases/get_student_grade.dart';

@lazySingleton
class GetAttendanceForStudent
    extends Usecase<Either<Failure, AttendanceEntity>, GetStudentsParams> {
  final AttendanceRepository _repository;

  GetAttendanceForStudent(this._repository);
  @override
  Future<Either<Failure, AttendanceEntity>> call(
      {required GetStudentsParams params}) async {
    return _repository.getAttendanceForStudent(
      params.studentId,
      params.courseId,
    );
  }
}
