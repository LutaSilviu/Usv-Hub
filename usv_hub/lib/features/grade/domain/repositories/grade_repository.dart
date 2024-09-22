import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';
import 'package:usv_hub/features/grade/domain/entities/grade_entity.dart';

abstract class GradeRepository {
  Future<Either<Failure, Map<GradeEntity, CourseEntity>>> getAllCourses();
}
