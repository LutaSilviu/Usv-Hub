import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/assigments/domain/entities/assigment_entity.dart';
import 'package:usv_hub/features/assigments/domain/repositories/assigments_repo.dart';

@LazySingleton()
class GetAssigmentsUsecase
    extends Usecase<Either<Failure, List<AssigmentEntity>>, String> {
  final AssigmentsRepo _assigmentsRepo;

  GetAssigmentsUsecase(this._assigmentsRepo);
  @override
  Future<Either<Failure, List<AssigmentEntity>>> call(
      {required String params}) {
    return _assigmentsRepo.getAssigments(params);
  }
}
