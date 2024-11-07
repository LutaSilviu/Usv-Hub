import 'package:dartz/dartz.dart';

import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/select_course/domain/entities/course_entity.dart';

import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/select_course/domain/repositories/courses_repository.dart';

@lazySingleton
class GetAllCourses
    implements Usecase<Either<Failure, Map<ProfesorType, CourseEntity>>, void> {
  final CoursesRepository _coursesRepository;

  GetAllCourses(
    this._coursesRepository,
  );

  @override
  Future<Either<Failure, Map<ProfesorType, CourseEntity>>> call({void params}) {
    return _coursesRepository.getAllCoursesForStudents();
  }
}
