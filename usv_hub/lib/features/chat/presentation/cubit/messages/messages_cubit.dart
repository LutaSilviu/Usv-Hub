import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usv_hub/features/chat/domain/entities/messaje_entity.dart';
import 'package:usv_hub/features/chat/domain/repositories/chat_repo.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  final ChatRepo _chatRepo;
  MessagesCubit(this._chatRepo) : super(MessagesInitial());

  Future<void> sendMessaje(MessageEntity message) async {
    emit(MessagesLoading());

    (await _chatRepo.sendMesage(message)).fold(
      (l) => emit(MessagesError(l.message)),
      (r) => null,
    );
  }
}
