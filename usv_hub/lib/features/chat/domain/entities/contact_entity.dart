import 'package:equatable/equatable.dart';
import 'package:usv_hub/core/utils/consts.dart';

class ContactEntity extends Equatable {
  final String id;
  final String contactName;
  final String person1;
  final String person2;
  final ContactsStatus status;

  const ContactEntity({
    required this.id,
    required this.status,
    required this.contactName,
    required this.person1,
    required this.person2,
  });

  @override
  List<Object?> get props => [contactName, person1, person2, status, id];
}
