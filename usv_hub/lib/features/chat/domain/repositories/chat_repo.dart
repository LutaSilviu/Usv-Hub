import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/chat/domain/entities/contact_entity.dart';
import 'package:usv_hub/features/chat/domain/entities/messaje_entity.dart';

abstract class ChatRepo {
  Future<Either<Failure, List<ContactEntity>>> getAllContacts();
  // Stream<Either<Failure, MessageEntity>> getAllMessages(String id);

  Future<Either<Failure, void>> sendMesage(MessageEntity mesajeEntity);
}
