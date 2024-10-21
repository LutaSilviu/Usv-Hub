import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/chat/domain/entities/messaje_entity.dart';
import 'package:usv_hub/features/chat/domain/repositories/chat_repo.dart';

@LazySingleton()
class SendMessageUsecase extends Usecase<Either<Failure, void>, MessageEntity> {
  final ChatRepo _chatRepo;

  SendMessageUsecase(this._chatRepo);

  @override
  Future<Either<Failure, void>> call({required MessageEntity params}) async {
    return _chatRepo.sendMesage(params);
  }
}
