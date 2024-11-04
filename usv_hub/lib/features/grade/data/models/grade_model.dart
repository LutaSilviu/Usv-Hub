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
          ? map[AppFields.courseGrade] as double
          : null,
      labGrade: map[AppFields.labGrade] != null
          ? map[AppFields.labGrade] as double
          : null,
      courseId: map[AppFields.courseId] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GradeModel.fromJson(String source) =>
      GradeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  GradeModel copyWith(String? id) {
    return GradeModel(
      id: id ?? this.id,
      studentId: studentId,
      courseGrade: courseGrade,
      labGrade: labGrade,
      courseId: courseId,
    );
  }
}
