import 'dart:convert';

import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';

class CourseModel extends CourseEntity {
  const CourseModel(
      {required super.id,
      required super.teacherId,
      required super.assistentId,
      required super.title,
      required super.classNumber,
      required super.courseCredits,
      required super.scheduleMap,
      required super.semester});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'teacherId': teacherId,
      'assistentId': assistentId,
      'title': title,
      'classNumber': classNumber,
      'courseCredits': courseCredits,
      'scheduleMap': scheduleMap,
      'semester': semester,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] as String,
      teacherId: map['teacherId'] as String,
      assistentId: map['assistentId'] as String,
      title: map['title'] as String,
      classNumber: map['classNumber'] as int,
      courseCredits: map['courseCredits'] as int,
      semester: map['semester'] as String,
      scheduleMap: map['scheduleMap'] as List<Map<String, dynamic>>,
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
