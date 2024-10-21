import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/events/domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  EventModel(
      {required super.id,
      required super.departamentId,
      required super.title,
      required super.startTime,
      required super.endTime,
      required super.classWhereHeld,
      required super.supporterName});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      AppFields.id: id,
      AppFields.departamentId: departamentId,
      AppFields.title: title,
      AppFields.startTime: Timestamp.fromDate(startTime),
      AppFields.endTime: Timestamp.fromDate(endTime),
      AppFields.classWhereHeld: classWhereHeld,
      AppFields.supporterName: supporterName,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map[AppFields.id] as String,
      departamentId: map[AppFields.departamentId] as String,
      title: map[AppFields.title] as String,
      startTime: (map[AppFields.startTime] as Timestamp).toDate(),
      endTime: (map[AppFields.endTime] as Timestamp).toDate(),
      classWhereHeld: map[AppFields.classWhereHeld] as String,
      supporterName: map[AppFields.supporterName] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
