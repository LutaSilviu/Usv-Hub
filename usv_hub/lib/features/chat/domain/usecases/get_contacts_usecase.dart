import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/chat/domain/entities/contact_entity.dart';
import 'package:usv_hub/features/chat/domain/repositories/chat_repo.dart';

@LazySingleton()
class GetContactsUsecase
    extends Usecase<Either<Failure, List<ContactEntity>>, void> {
  final ChatRepo _chatRepo;

  GetContactsUsecase(this._chatRepo);

  @override
  Future<Either<Failure, List<ContactEntity>>> call({void params}) async {
    return _chatRepo.getAllContacts();
  }
}
