import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/attendance/data/models/attendance_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AttendanceApiService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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
