import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/attendance/data/datasources/attendance_api_service.dart';
import 'package:usv_hub/features/attendance/data/models/attendance_model.dart';
import 'package:usv_hub/features/attendance/domain/entities/attendance_entity.dart';
import 'package:usv_hub/features/attendance/domain/repositories/attendance_repository.dart';
import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AttendanceRepository)
class AttendanceRepoImpl implements AttendanceRepository {
  final AttendanceApiService _attendanceApiService;

  AttendanceRepoImpl(this._attendanceApiService);
  @override
  Future<Either<Failure, Map<AttendanceEntity, CourseEntity>>>
      getAttendance() async {
    try {
      return Right(await _attendanceApiService.getAttendance());
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> addAttendance(
      AttendanceEntity attendanceEntity) async {
    try {
      AttendanceModel attendanceModel = AttendanceModel(
        id: attendanceEntity.id,
        courseId: attendanceEntity.courseId,
        studentId: attendanceEntity.studentId,
        courseAttendance: attendanceEntity.courseAttendance,
        labortoryAttendance: attendanceEntity.labortoryAttendance,
      );
      return Right(await _attendanceApiService.addAttendance(attendanceModel));
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, AttendanceEntity>> getAttendanceForStudent(
      String studentId, String courseId) async {
    try {
      return Right(
        await _attendanceApiService.getAttendanceForStudent(
          studentId,
          courseId,
        ),
      );
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }
}
