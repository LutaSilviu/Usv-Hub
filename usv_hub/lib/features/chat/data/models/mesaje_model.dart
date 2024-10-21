import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/chat/domain/entities/messaje_entity.dart';

class MesajeModel extends MessageEntity {
  const MesajeModel({
    required super.id,
    required super.text,
    required super.senderId,
    required super.contactId,
    required super.timeWhenSent,
  });

  factory MesajeModel.fromJson(Map<String, dynamic> json) {
    return MesajeModel(
      id: json[AppFields.id],
      text: json[AppFields.text],
      senderId: json[AppFields.senderId],
      contactId: json[AppFields.contactId],
      timeWhenSent: (json[AppFields.timeWhenSent] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppFields.id: id,
      AppFields.text: text,
      AppFields.senderId: senderId,
      AppFields.contactId: contactId,
      AppFields.timeWhenSent: Timestamp.fromDate(timeWhenSent),
    };
  }
}
