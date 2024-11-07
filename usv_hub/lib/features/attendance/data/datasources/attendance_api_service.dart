import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/attendance/data/models/attendance_model.dart';
import 'package:usv_hub/features/grade/data/models/course_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AttendanceApiService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  Future<Map<AttendanceModel, CourseModel>> getAttendance() async {
    try {
      Map<AttendanceModel, CourseModel> coursesAndAttendance = {};
      final result = await _firebaseFirestore
          .collection(AppCollections.attendanceCollection)
          .where(AppFields.studentId, isEqualTo: _firebaseAuth.currentUser!.uid)
          .get();

      for (final doc in result.docs) {
        final AttendanceModel attendanceModel =
            AttendanceModel.fromMap(doc.data());

        final courseDocs = await _firebaseFirestore
            .collection(AppCollections.courseCollection)
            .where(AppFields.id, isEqualTo: attendanceModel.courseId)
            .get();

        //relatia intre Attendance si Course e 1 la 1,deci nu va putea fi mai mult de 1 curs per attendance
        final CourseModel courseModel = CourseModel.fromMap(
          courseDocs.docs.first.data(),
        );
        coursesAndAttendance.putIfAbsent(attendanceModel, () => courseModel);
      }
      return coursesAndAttendance;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    }
  }

  Future<void> addAttendance(AttendanceModel attendanceModel) async {
    try {
      await _firebaseFirestore
          .collection(AppCollections.attendanceCollection)
          .doc(attendanceModel.id)
          .set(attendanceModel.toMap());
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    }
  }

  Future<AttendanceModel> getAttendanceForStudent(
      String studentId, String courseId) async {
    try {
      final result = await _firebaseFirestore
          .collection(AppCollections.attendanceCollection)
          .where(AppFields.studentId, isEqualTo: studentId)
          .where(AppFields.courseId, isEqualTo: courseId)
          .get();

      final AttendanceModel attendanceModel =
          AttendanceModel.fromMap(result.docs.first.data());

      return attendanceModel;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    }
  }
}
