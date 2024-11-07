import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/select_course/domain/entities/course_entity.dart';

abstract class CoursesRepository {
  Future<Either<Failure, Map<ProfesorType, CourseEntity>>>
      getAllCoursesForStudents();

  Future<Either<Failure, Map<ProfesorType, CourseEntity>>>
      getAllCoursesForTeachers();
}
