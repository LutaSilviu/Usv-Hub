import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/assigments/domain/entities/submision_entity.dart';
import 'package:usv_hub/features/assigments/domain/repositories/assigments_repo.dart';

@LazySingleton()
class PostSubbmisionUsecase
    extends Usecase<Either<Failure, void>, SubmisionEntity> {
  final AssigmentsRepo _assigmentsRepo;

  PostSubbmisionUsecase(this._assigmentsRepo);

  @override
  Future<Either<Failure, void>> call({required SubmisionEntity params}) {
    return _assigmentsRepo.postSubmission(params);
  }
}
