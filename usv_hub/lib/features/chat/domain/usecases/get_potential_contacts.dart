import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';
import 'package:usv_hub/features/chat/domain/repositories/chat_repo.dart';

@LazySingleton()
class GetPotentialContacts
    extends Usecase<Either<Failure, List<UserEntity>>, List<String>> {
  final ChatRepo _chatRepo;

  GetPotentialContacts(this._chatRepo);

  @override
  Future<Either<Failure, List<UserEntity>>> call(
      {required List<String> params}) {
    return _chatRepo.getPotentialContacts(params);
  }
}
