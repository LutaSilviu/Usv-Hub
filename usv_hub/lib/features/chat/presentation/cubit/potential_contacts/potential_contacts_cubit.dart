import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/chat/domain/entities/contact_entity.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';
import 'package:usv_hub/features/chat/domain/usecases/create_contact.dart';
import 'package:usv_hub/features/chat/domain/usecases/get_potential_contacts.dart';

part 'potential_contacts_state.dart';

@injectable
class PotentialContactsCubit extends Cubit<PotentialContactsState> {
  PotentialContactsCubit(this._getPotentialContacts, this._createContact)
      : super(PotentialContactsInitial());

  final GetPotentialContacts _getPotentialContacts;
  final CreateContact _createContact;

  Future<void> getPotentialContacts(List<String> contacts) async {
    emit(PotentialContactsLoading());

    (await _getPotentialContacts.call(params: contacts)).fold(
      (failure) => emit(PotentialContactsError(failure.message)),
      (contacts) => emit(PotentialContactsLoaded(contacts)),
    );
  }

  Future<void> createContact(
      ContactEntity contact, PotentialContactsLoaded state) async {
    emit(PotentialContactsLoading());

    (await _createContact.call(params: contact)).fold(
      (failure) => emit(PotentialContactsError(failure.message)),
      (succes) {
        state.contacts.clear();
        emit(
          PotentialContactsLoaded(
            state.contacts,
          ),
        );
      },
    );
  }
}
