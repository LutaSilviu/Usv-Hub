import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/assigments/domain/entities/assigment_entity.dart';

class AssigmentsModel extends AssigmentEntity {
  const AssigmentsModel({
    required super.id,
    required super.courseId,
    required super.title,
    required super.description,
    required super.startTime,
    required super.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      AppFields.id: id,
      AppFields.courseId: courseId,
      AppFields.title: title,
      AppFields.description: description,
      AppFields.startTime: Timestamp.fromDate(startTime),
      AppFields.endTime: Timestamp.fromDate(endTime)
    };
  }

  factory AssigmentsModel.fromMap(Map<String, dynamic> map) {
    return AssigmentsModel(
      id: map[AppFields.id],
      courseId: map[AppFields.courseId],
      title: map[AppFields.title],
      description: map[AppFields.description],
      startTime: (map[AppFields.startTime] as Timestamp).toDate(),
      endTime: (map[AppFields.endTime] as Timestamp).toDate(),
    );
  }
}

  //ToMap with timestamp-datetime conversion


