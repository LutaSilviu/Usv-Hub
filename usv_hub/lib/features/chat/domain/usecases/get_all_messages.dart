import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/chat/domain/entities/messaje_entity.dart';
import 'package:usv_hub/features/chat/domain/repositories/chat_repo.dart';

@LazySingleton()
class GetAllMessages
    extends Usecase<Future<Either<Failure, List<MessageEntity>>>, String> {
  final ChatRepo _chatRepo;

  GetAllMessages(this._chatRepo);

  @override
  Future<Future<Either<Failure, List<MessageEntity>>>> call(
      {required String params}) async {
    return _chatRepo.getAllMessages(params);
  }
}
