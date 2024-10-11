import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usv_hub/features/chat/domain/entities/contact_entity.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(ContactsInitial());
}
