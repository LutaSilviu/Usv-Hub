import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/assigments/data/datasources/assigments_api_service.dart';
import 'package:usv_hub/features/assigments/domain/entities/assigment_entity.dart';
import 'package:usv_hub/features/assigments/domain/entities/submision_entity.dart';
import 'package:usv_hub/features/assigments/domain/repositories/assigments_repo.dart';
import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';

@LazySingleton(as: AssigmentsRepo)
class AssigmentsRepoImpl extends AssigmentsRepo {
  final AssigmentsApiService _assigmentsApiService;

  AssigmentsRepoImpl(this._assigmentsApiService);

  @override
  Future<Either<Failure, Map<AssigmentEntity, CourseEntity>>>
      getAssigments() async {
    try {
      return Right(await _assigmentsApiService.getAssigments());
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> postSubmission(SubmisionEntity submision) {
    // TODO: implement postSubmission
    throw UnimplementedError();
  }
}
