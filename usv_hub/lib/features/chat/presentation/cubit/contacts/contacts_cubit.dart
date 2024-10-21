import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/chat/domain/entities/contact_entity.dart';
import 'package:usv_hub/features/chat/domain/usecases/get_contacts_usecase.dart';

part 'contacts_state.dart';

@injectable
class ContactsCubit extends Cubit<ContactsState> {
  final GetContactsUsecase _chatRepo;
  ContactsCubit(this._chatRepo) : super(ContactsInitial());

  Future<void> getContacts() async {
    emit(ContactsLoading());

    (await _chatRepo.call()).fold(
      (failure) => emit(ContactsError(failure.message)),
      (contacts) => emit(ContactsLoaded(contacts)),
    );
  }
}
