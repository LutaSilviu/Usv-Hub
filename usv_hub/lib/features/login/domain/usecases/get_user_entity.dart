import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';
import 'package:usv_hub/features/login/domain/repositories/auth_repo.dart';

class GetUserEntity
    extends Usecase<Either<Failure, Map<SelectedType, UserEntity>>, void> {
  AuthRepo authRepo;
  GetUserEntity({required this.authRepo});
  @override
  Future<Either<Failure, Map<SelectedType, UserEntity>>> call(
      {required void params}) {
    return authRepo.getUserEntity();
  }
}
