import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/chat/domain/entities/contact_entity.dart';
import 'package:usv_hub/features/chat/domain/repositories/chat_repo.dart';

@LazySingleton()
class CreateContact extends Usecase<Either<Failure, void>, ContactEntity> {
  ChatRepo _chatRepo;

  CreateContact(this._chatRepo);

  @override
  Future<Either<Failure, void>> call({required ContactEntity params}) {
    return _chatRepo.createContact(params);
  }
}
