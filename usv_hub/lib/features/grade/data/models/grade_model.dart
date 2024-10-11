import 'dart:convert';

import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/grade/domain/entities/grade_entity.dart';

class GradeModel extends GradeEntity {
  const GradeModel({
    required super.id,
    required super.studentId,
    required super.courseGrade,
    required super.labGrade,
    required super.courseId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      AppFields.id: id,
      AppFields.studentId: studentId,
      AppFields.courseGrade: courseGrade,
      AppFields.labGrade: labGrade,
      AppFields.courseId: courseId,
    };
  }

  factory GradeModel.fromMap(Map<String, dynamic> map) {
    return GradeModel(
      id: map[AppFields.id] as String,
      studentId: map[AppFields.studentId] as String,
      courseGrade: map[AppFields.courseGrade] != null
          ? map[AppFields.courseGrade] as int
          : null,
      labGrade: map[AppFields.labGrade] != null
          ? map[AppFields.labGrade] as int
          : null,
      courseId: map[AppFields.courseId] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory GradeModel.fromJson(String source) =>
      GradeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
