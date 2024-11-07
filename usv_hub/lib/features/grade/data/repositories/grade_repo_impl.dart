import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';
import 'package:usv_hub/features/grade/data/datasources/grade_api_service.dart';
import 'package:usv_hub/features/grade/data/models/grade_model.dart';
import 'package:usv_hub/features/grade/domain/entities/grade_entity.dart';
import 'package:usv_hub/features/grade/domain/repositories/grade_repository.dart';

import 'package:injectable/injectable.dart';

@LazySingleton(as: GradeRepository)
class GradeRepoImpl extends GradeRepository {
  final GradeApiService _gradeApiService;
  GradeRepoImpl(this._gradeApiService);

  @override
  Future<Either<Failure, List<UserEntity>>> getStudentsForCourse(
      String courseId) async {
    try {
      return Right(await _gradeApiService.getStudentsForCourse(courseId));
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GradeEntity?>> getStudentGrade(
      String studentId, String courseId) async {
    try {
      return Right(await _gradeApiService.getStudentGrade(studentId, courseId));
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> addStudentGrade(GradeEntity grade) async {
    try {
      GradeModel gradeModel = GradeModel(
        id: grade.id,
        studentId: grade.studentId,
        courseGrade: grade.courseGrade,
        labGrade: grade.labGrade,
        courseId: grade.courseId,
      );
      return Right(await _gradeApiService.addStudentGrade(gradeModel));
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }
}
