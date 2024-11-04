import 'package:dartz/dartz.dart';

import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/grade/domain/entities/grade_entity.dart';
import 'package:usv_hub/features/grade/domain/repositories/grade_repository.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class GetStudentGrade
    implements Usecase<Either<Failure, GradeEntity?>, GetStudentsParams> {
  final GradeRepository _gradeRepository;

  GetStudentGrade(
    this._gradeRepository,
  );

  @override
  Future<Either<Failure, GradeEntity?>> call(
      {required GetStudentsParams params}) {
    return _gradeRepository.getStudentGrade(params.studentId, params.courseId);
  }
}

class GetStudentsParams {
  String studentId;
  String courseId;

  GetStudentsParams(this.studentId, this.courseId);
}
