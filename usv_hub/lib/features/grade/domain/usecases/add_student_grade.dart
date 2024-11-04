// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/grade/domain/entities/grade_entity.dart';
import 'package:usv_hub/features/grade/domain/repositories/grade_repository.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class AddStudentGrade implements Usecase<Either<Failure, void>, GradeEntity> {
  final GradeRepository _gradeRepository;

  AddStudentGrade(
    this._gradeRepository,
  );

  @override
  Future<Either<Failure, void>> call({required GradeEntity params}) {
    return _gradeRepository.addStudentGrade(params);
  }
}
