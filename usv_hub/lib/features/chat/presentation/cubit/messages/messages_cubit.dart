import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/chat/domain/entities/messaje_entity.dart';
import 'package:usv_hub/features/chat/domain/usecases/send_message_usecase.dart';

part 'messages_state.dart';

@injectable
class MessagesCubit extends Cubit<MessagesState> {
  final SendMessageUsecase _chatRepo;
  MessagesCubit(this._chatRepo) : super(MessagesInitial());

  Future<void> sendMessaje(MessageEntity message) async {
    emit(MessagesLoading());

    (await _chatRepo.call(params: message)).fold(
      (l) => emit(MessagesError(l.message)),
      (r) => null,
    );
  }
}
