import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/assigments/domain/entities/submision_entity.dart';
import 'package:usv_hub/features/assigments/domain/repositories/assigments_repo.dart';

@LazySingleton()
class GetSubmissionsUsecase
    extends Usecase<Either<Failure, Map<SubmisionEntity, String>>, String> {
  final AssigmentsRepo _assigmentsRepo;

  GetSubmissionsUsecase(this._assigmentsRepo);
  @override
  Future<Either<Failure, Map<SubmisionEntity, String>>> call(
      {required String params}) {
    return _assigmentsRepo.getSubbmisions(params);
  }
}
