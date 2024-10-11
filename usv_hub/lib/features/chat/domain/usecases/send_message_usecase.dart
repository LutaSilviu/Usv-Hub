import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/chat/domain/entities/messaje_entity.dart';
import 'package:usv_hub/features/chat/domain/repositories/chat_repo.dart';

@LazySingleton()
class GetContactsUsecase
    extends Usecase<Future<Either<Failure, void>>, MessageEntity> {
  final ChatRepo _chatRepo;

  GetContactsUsecase(this._chatRepo);

  @override
  Future<Future<Either<Failure, void>>> call(
      {required MessageEntity params}) async {
    return _chatRepo.sendMesage(params);
  }
}
