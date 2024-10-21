import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/chat/data/datasources/chat_firestore_api.dart';
import 'package:usv_hub/features/chat/domain/entities/messaje_entity.dart';

@LazySingleton()
class GetAllMessages {
  final ChatFirestoreApi _chatRepo;

  GetAllMessages(this._chatRepo);

  Stream<List<MessageEntity>> call({required String params}) {
    return _chatRepo.getMessages(params);
  }
}
