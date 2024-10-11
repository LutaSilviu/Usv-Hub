import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/utils/consts.dart';

import 'package:usv_hub/features/grade/data/models/course_model.dart';
import 'package:usv_hub/features/grade/data/models/grade_model.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class GradeApiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<Map<GradeModel, CourseModel>> getAllCourses() async {
    try {
      String userId = user!.uid;
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
}
