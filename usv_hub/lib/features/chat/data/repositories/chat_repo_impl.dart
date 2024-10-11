import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/chat/data/datasources/chat_firestore_api.dart';
import 'package:usv_hub/features/chat/data/models/mesaje_model.dart';
import 'package:usv_hub/features/chat/domain/entities/contact_entity.dart';
import 'package:usv_hub/features/chat/domain/entities/messaje_entity.dart';
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
  Future<Either<Failure, List<MessageEntity>>> getAllMessages(String id) async {
    try {
      return Right(await _chatFirestoreApi.getAllMessages(id));
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> sendMesage(MessageEntity mesajeEntity) async {
    try {
      return Right(
          await _chatFirestoreApi.sendMesage(mesajeEntity as MesajeModel));
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }
}
