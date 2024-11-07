import 'package:dartz/dartz.dart';

import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';
import 'package:usv_hub/features/grade/domain/repositories/grade_repository.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllCoursesForTeacher
    implements Usecase<Either<Failure, Map<ProfesorType, CourseEntity>>, void> {
  final GradeRepository _gradeRepository;

  GetAllCoursesForTeacher(
    this._gradeRepository,
  );

  @override
  Future<Either<Failure, Map<ProfesorType, CourseEntity>>> call({void params}) {
    return _gradeRepository.getAllCoursesForTeachers();
  }
}
