import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/chat/domain/entities/contact_entity.dart';
import 'package:usv_hub/features/chat/domain/entities/messaje_entity.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';

abstract class ChatRepo {
  Future<Either<Failure, List<ContactEntity>>> getAllContacts();
  Future<Either<Failure, void>> sendMesage(MessageEntity mesajeEntity);

  Future<Either<Failure, List<UserEntity>>> getPotentialContacts(
    List<String> contacts,
  );
  Future<Either<Failure, void>> createContact(ContactEntity contact);
}
