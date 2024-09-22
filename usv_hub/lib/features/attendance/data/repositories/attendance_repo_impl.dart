import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/attendance/data/datasources/attendance_api_service.dart';
import 'package:usv_hub/features/attendance/domain/entities/attendance_entity.dart';
import 'package:usv_hub/features/attendance/domain/repositories/attendance_repository.dart';
import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';

class AttendanceRepoImpl implements AttendanceRepository {
  final AttendanceApiService _gradeApiService;

  AttendanceRepoImpl(this._gradeApiService);
  @override
  Future<Either<Failure, Map<AttendanceEntity, CourseEntity>>>
      getAttendance() async {
    try {
      return Right(await _gradeApiService.getAttendance());
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }
}
