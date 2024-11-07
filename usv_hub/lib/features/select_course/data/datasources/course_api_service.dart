import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/attendance/data/models/attendance_model.dart';
import 'package:usv_hub/features/select_course/data/models/course_model.dart';

@lazySingleton
class CourseApiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  Future<Map<ProfesorType, CourseModel>> getAllCoursesForStudent() async {
    try {
      Map<ProfesorType, CourseModel> coursesAndAttendance = {};
      final result = await _firestore
          .collection(AppCollections.attendanceCollection)
          .where(AppFields.studentId, isEqualTo: _firebaseAuth.currentUser!.uid)
          .get();

      for (final doc in result.docs) {
        final AttendanceModel attendanceModel =
            AttendanceModel.fromMap(doc.data());

        final courseDocs = await _firestore
            .collection(AppCollections.courseCollection)
            .where(AppFields.id, isEqualTo: attendanceModel.courseId)
            .get();

        //relatia intre Attendance si Course e 1 la 1,deci nu va putea fi mai mult de 1 curs per attendance
        final CourseModel courseModel = CourseModel.fromMap(
          courseDocs.docs.first.data(),
        );
        coursesAndAttendance.putIfAbsent(ProfesorType.none, () => courseModel);
      }
      return coursesAndAttendance;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    }
  }

  Future<Map<ProfesorType, CourseModel>> getAllCoursesForTeacher() async {
    try {
      String userId = _firebaseAuth.currentUser!.uid;
      Map<ProfesorType, CourseModel> coursesAndGrades = {};

      final response1 = await _firestore
          .collection(AppCollections.courseCollection)
          .where(AppFields.teacherId, isEqualTo: userId)
          .get();

      for (var doc in response1.docs) {
        final course = CourseModel.fromMap(doc.data());
        if (course.assistentId != course.teacherId) {
          coursesAndGrades.putIfAbsent(ProfesorType.teacher, () => course);
        } else {
          coursesAndGrades.putIfAbsent(ProfesorType.both, () => course);
        }
      }

      final response2 = await _firestore
          .collection(AppCollections.courseCollection)
          .where(AppFields.assistentId, isEqualTo: userId)
          .get();

      for (var doc in response2.docs) {
        final course = CourseModel.fromMap(doc.data());
        if (course.assistentId != course.teacherId) {
          coursesAndGrades.putIfAbsent(
              ProfesorType.assistent, () => CourseModel.fromMap(doc.data()));
        }
      }

      return coursesAndGrades;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    }
  }
}
