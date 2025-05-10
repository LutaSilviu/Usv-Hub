import 'package:dartz/dartz.dart';

import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/select_course/domain/entities/course_entity.dart';

import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/select_course/domain/repositories/courses_repository.dart';

@lazySingleton
class GetAllCoursesForTeacher
    implements
        Usecase<Either<Failure, Map<ProfesorType, List<CourseEntity>>>, void> {
  final CoursesRepository _courseRepository;

  GetAllCoursesForTeacher(
    this._courseRepository,
  );

  @override
  Future<Either<Failure, Map<ProfesorType, List<CourseEntity>>>> call(
      {void params}) {
    return _courseRepository.getAllCoursesForTeachers();
  }
}
