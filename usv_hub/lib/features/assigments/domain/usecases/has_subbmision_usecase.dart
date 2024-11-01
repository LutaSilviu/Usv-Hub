import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/assigments/domain/repositories/assigments_repo.dart';

@LazySingleton()
class HasSubbmissionUsecase extends Usecase<Either<Failure, bool>, String> {
  final AssigmentsRepo _assigmentsRepo;

  HasSubbmissionUsecase(this._assigmentsRepo);

  @override
  Future<Either<Failure, bool>> call({required String params}) {
    return _assigmentsRepo.hasSubbmision(params);
  }
}
