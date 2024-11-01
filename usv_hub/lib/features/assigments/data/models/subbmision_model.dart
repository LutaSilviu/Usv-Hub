import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/assigments/domain/entities/submision_entity.dart';

class SubbmisionModel extends SubmisionEntity {
  const SubbmisionModel(
    super.id,
    super.assigmentId,
    super.studentId,
    super.downloadUrl,
    super.postDate,
  );

  factory SubbmisionModel.fromMap(Map<String, dynamic> map) {
    return SubbmisionModel(
      map[AppFields.id],
      map[AppFields.assigmentId],
      map[AppFields.studentId],
      map[AppFields.downloadUrl],
      map[AppFields.postDate],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      AppFields.id: id,
      AppFields.assigmentId: assigmentId,
      AppFields.studentId: studentId,
      AppFields.downloadUrl: downloadUrl,
      AppFields.postDate: postDate,
    };
  }

  copyWith({String? id, String? studId}) {
    return SubbmisionModel(
      id ?? this.id,
      assigmentId,
      studId ?? studentId,
      downloadUrl,
      postDate,
    );
  }
}
