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
      AppModels.id: id,
      AppModels.studentId: studentId,
      AppModels.courseGrade: courseGrade,
      AppModels.labGrade: labGrade,
      AppModels.courseId: courseId,
    };
  }

  factory GradeModel.fromMap(Map<String, dynamic> map) {
    return GradeModel(
      id: map[AppModels.id] as String,
      studentId: map[AppModels.studentId] as String,
      courseGrade: map[AppModels.courseGrade] != null
          ? map[AppModels.courseGrade] as int
          : null,
      labGrade: map[AppModels.labGrade] != null
          ? map[AppModels.labGrade] as int
          : null,
      courseId: map[AppModels.courseId] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory GradeModel.fromJson(String source) =>
      GradeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
