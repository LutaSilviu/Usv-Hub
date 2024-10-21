import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/chat/domain/entities/contact_entity.dart';

class ContactModel extends ContactEntity {
  const ContactModel({
    required super.id,
    required super.status,
    required super.person1,
    required super.person2,
    required super.contactName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      AppFields.id: id,
      AppFields.status: status.name,
      AppFields.person1: person1,
      AppFields.person2: person2,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map, String contactName) {
    return ContactModel(
      contactName: contactName,
      id: map[AppFields.id] as String,
      status: (map[AppFields.status] as String).toContactsStatus()!,
      person1: map[AppFields.person1] as String,
      person2: map[AppFields.person2] as String,
    );
  }
}
