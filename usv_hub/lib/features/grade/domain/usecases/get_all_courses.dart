// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';
import 'package:usv_hub/features/grade/domain/entities/grade_entity.dart';
import 'package:usv_hub/features/grade/domain/repositories/grade_repository.dart';

class GetAllCourses
    implements Usecase<Either<Failure, Map<GradeEntity, CourseEntity>>, void> {
  final GradeRepository _gradeRepository;

  GetAllCourses(
    this._gradeRepository,
  );

  @override
  Future<Either<Failure, Map<GradeEntity, CourseEntity>>> call({void params}) {
    return _gradeRepository.getAllCourses();
  }
}
