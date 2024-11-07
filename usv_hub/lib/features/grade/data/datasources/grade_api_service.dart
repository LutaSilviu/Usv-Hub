import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/chat/data/models/user_model.dart';

import 'package:usv_hub/features/grade/data/models/grade_model.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class GradeApiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getStudentsForCourse(String courseId) async {
    try {
      List<UserModel> students = [];
      final attendanceResponse = await _firestore
          .collection(AppCollections.attendanceCollection)
          .where(AppFields.courseId, isEqualTo: courseId)
          .get();

      for (final attendance in attendanceResponse.docs) {
        final studentResponse = await _firestore
            .collection(AppCollections.student)
            .where(AppFields.id, isEqualTo: attendance[AppFields.studentId])
            .limit(1)
            .get();

        students.add(UserModel.fromJson(studentResponse.docs.first.data()));
      }

      return students;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    }
  }

  Future<GradeModel?> getStudentGrade(String studentId, String courseId) async {
    try {
      final gradeResponse = await _firestore
          .collection(AppCollections.gradeCollection)
          .where(AppFields.studentId, isEqualTo: studentId)
          .where(AppFields.courseId, isEqualTo: courseId)
          .limit(1)
          .get();

      if (gradeResponse.docs.isNotEmpty) {
        return GradeModel.fromMap(gradeResponse.docs.first.data());
      }

      return null;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    }
  }

  Future<void> addStudentGrade(GradeModel grade) async {
    try {
      if (grade.id == "") {
        final doRef =
            _firestore.collection(AppCollections.gradeCollection).doc();
        grade = grade.copyWith(doRef.id);
        await doRef.set(grade.toMap());
      } else {
        _firestore.collection(AppCollections.gradeCollection).doc(grade.id).set(
              grade.toMap(),
            );
      }
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    }
  }
}
