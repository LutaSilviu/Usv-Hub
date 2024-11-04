import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/chat/data/models/user_model.dart';

import 'package:usv_hub/features/grade/data/models/course_model.dart';
import 'package:usv_hub/features/grade/data/models/grade_model.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class GradeApiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  Future<Map<GradeModel, CourseModel>> getAllCoursesForStudent() async {
    try {
      String userId = _firebaseAuth.currentUser!.uid;
      Map<GradeModel, CourseModel> coursesAndGrades = {};

      final docs = await _firestore
          .collection(AppCollections.gradeCollection)
          .where(AppFields.studentId, isEqualTo: userId)
          .get();

      for (var doc in docs.docs) {
        GradeModel model = GradeModel.fromMap(doc.data());

        final courseDocs = await _firestore
            .collection(AppCollections.courseCollection)
            .where(AppFields.id, isEqualTo: model.courseId)
            .get();

        //relatia intre Grade si Course e 1 la 1,deci nu va putea fi mai mult de 1 curs per grade
        coursesAndGrades.putIfAbsent(
            model, () => CourseModel.fromMap(courseDocs.docs.first.data()));
      }

      return coursesAndGrades;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    }
  }

  Future<Map<bool, CourseModel>> getAllCoursesForTeacher() async {
    try {
      String userId = _firebaseAuth.currentUser!.uid;
      Map<bool, CourseModel> coursesAndGrades = {};

      final response1 = await _firestore
          .collection(AppCollections.courseCollection)
          .where(AppFields.teacherId, isEqualTo: userId)
          .get();

      for (var doc in response1.docs) {
        coursesAndGrades.putIfAbsent(
            true, () => CourseModel.fromMap(doc.data()));
      }

      final response2 = await _firestore
          .collection(AppCollections.courseCollection)
          .where(AppFields.assistentId, isEqualTo: userId)
          .get();

      for (var doc in response2.docs) {
        coursesAndGrades.putIfAbsent(
            false, () => CourseModel.fromMap(doc.data()));
      }

      return coursesAndGrades;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    }
  }

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
