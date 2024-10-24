import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/chat/data/datasources/chat_firestore_api.dart';
import 'package:usv_hub/features/chat/data/models/contact_model.dart';
import 'package:usv_hub/features/chat/data/models/mesaje_model.dart';
import 'package:usv_hub/features/chat/domain/entities/contact_entity.dart';
import 'package:usv_hub/features/chat/domain/entities/messaje_entity.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';
import 'package:usv_hub/features/chat/domain/repositories/chat_repo.dart';

@LazySingleton(as: ChatRepo)
class ChatRepoImpl extends ChatRepo {
  final ChatFirestoreApi _chatFirestoreApi;

  ChatRepoImpl(this._chatFirestoreApi);

  @override
  Future<Either<Failure, List<ContactEntity>>> getAllContacts() async {
    try {
      return Right(await _chatFirestoreApi.getAllContacts());
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> sendMesage(MessageEntity mesajeEntity) async {
    try {
      MesajeModel model = MesajeModel(
        id: mesajeEntity.id,
        text: mesajeEntity.text,
        senderId: mesajeEntity.senderId,
        contactId: mesajeEntity.contactId,
        timeWhenSent: mesajeEntity.timeWhenSent,
      );
      return Right(await _chatFirestoreApi.sendMesage(model));
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getPotentialContacts(
      List<String> contacts) async {
    try {
      return Right(await _chatFirestoreApi.getPotentialContacts(contacts));
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> createContact(ContactEntity contact) async {
    try {
      ContactModel model = ContactModel(
        id: contact.id,
        status: contact.status,
        person1: contact.person1,
        person2: contact.person2,
        contactName: contact.contactName,
      );
      return Right(await _chatFirestoreApi.createContact(model));
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }
}
