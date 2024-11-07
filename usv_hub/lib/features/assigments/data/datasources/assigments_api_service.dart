import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/assigments/data/models/assigments_model.dart';
import 'package:usv_hub/features/assigments/data/models/subbmision_model.dart';
import 'package:usv_hub/features/assigments/domain/entities/assigment_entity.dart';
import 'package:usv_hub/features/grade/data/models/course_model.dart';

@LazySingleton()
class AssigmentsApiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  Future<Map<AssigmentEntity, CourseModel>> getAssigments() async {
    try {
      final String userId = _firebaseAuth.currentUser!.uid;
      final Map<AssigmentsModel, CourseModel> assigments = {};
      final courseResponse = await _firestore
          .collection(AppCollections.semesterXStudentCollection)
          .where(
            AppFields.studentId,
            isEqualTo: userId,
          )
          .where(AppFields.isActive, isEqualTo: true)
          .get();

      final semesterId = courseResponse.docs.first.get(AppFields.semesterId);

      final courses = await _firestore
          .collection(AppCollections.courseCollection)
          .where(AppFields.semesterId, isEqualTo: semesterId)
          .get();

      for (final course in courses.docs) {
        final CourseModel courseModel = CourseModel.fromMap(course.data());
        final response = await _firestore
            .collection(AppCollections.assignmentCollection)
            .where(
              AppFields.courseId,
              isEqualTo: courseModel.id,
            )
            .get();

        for (final doc in response.docs) {
          final data = doc.data();

          assigments.putIfAbsent(
              AssigmentsModel.fromMap(data), () => courseModel);
        }
      }

      return assigments;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    } catch (e) {
      throw MediumException(runtimeType, e.toString());
    }
  }

  Future<void> postSubbmision(SubbmisionModel subbmisionModel) async {
    try {
      final String userId = _firebaseAuth.currentUser!.uid;
      final docRef = _firestore.collection(AppCollections.submission).doc();
      docRef.set(subbmisionModel
          .copyWith(
            id: docRef.id,
            studId: userId,
          )
          .toMap());
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    } catch (e) {
      throw MediumException(runtimeType, "Ups, something went wrong");
    }
  }

  Future<bool> hasSubbmision(String assigmentId) async {
    try {
      final String userId = _firebaseAuth.currentUser!.uid;
      final result = await _firestore
          .collection(AppCollections.submission)
          .where(AppFields.studentId, isEqualTo: userId)
          .where(AppFields.assigmentId, isEqualTo: assigmentId)
          .limit(1)
          .get();

      return result.docs.isNotEmpty;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    } catch (e) {
      throw MediumException(runtimeType, "Ups, something went wrong");
    }
  }
}
