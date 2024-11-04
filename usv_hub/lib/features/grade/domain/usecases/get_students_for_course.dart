import 'package:dartz/dartz.dart';

import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';
import 'package:usv_hub/features/grade/domain/repositories/grade_repository.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class GetStudentsForCourse
    implements Usecase<Either<Failure, List<UserEntity>>, String> {
  final GradeRepository _gradeRepository;

  GetStudentsForCourse(
    this._gradeRepository,
  );

  @override
  Future<Either<Failure, List<UserEntity>>> call({required String params}) {
    return _gradeRepository.getStudentsForCourse(params);
  }
}
