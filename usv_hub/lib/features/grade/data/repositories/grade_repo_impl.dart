import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/grade/data/datasources/grade_api_service.dart';
import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';
import 'package:usv_hub/features/grade/domain/entities/grade_entity.dart';
import 'package:usv_hub/features/grade/domain/repositories/grade_repository.dart';

class GradeRepoImpl extends GradeRepository {
  final GradeApiService _gradeApiService = GradeApiService();
  @override
  Future<Either<Failure, Map<GradeEntity, CourseEntity>>>
      getAllCourses() async {
    try {
      return Right(await _gradeApiService.getAllCourses());
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }
}
