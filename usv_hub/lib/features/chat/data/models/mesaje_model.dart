import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/chat/domain/entities/messaje_entity.dart';

class MesajeModel extends MessageEntity {
  const MesajeModel({
    required super.id,
    required super.messaje,
    required super.senderId,
    required super.reciverId,
    required super.timeWhenSent,
  });

  factory MesajeModel.fromJson(Map<String, dynamic> json) {
    return MesajeModel(
      id: json[AppFields.id],
      messaje: json[AppFields.messaje],
      senderId: json[AppFields.senderId],
      reciverId: json[AppFields.reciverId],
      timeWhenSent: json[AppFields.timeWhenSent],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppFields.id: id,
      AppFields.messaje: messaje,
      AppFields.senderId: senderId,
      AppFields.reciverId: reciverId,
      AppFields.timeWhenSent: timeWhenSent,
    };
  }
}
