import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/assigments/domain/entities/assigment_entity.dart';
import 'package:usv_hub/features/assigments/domain/repositories/assigments_repo.dart';

@LazySingleton()
class PostAssigmentUsecase
    extends Usecase<Either<Failure, void>, AssigmentEntity> {
  final AssigmentsRepo _assigmentsRepo;

  PostAssigmentUsecase(this._assigmentsRepo);

  @override
  Future<Either<Failure, void>> call({required AssigmentEntity params}) {
    return _assigmentsRepo.postAssigment(params);
  }
}
