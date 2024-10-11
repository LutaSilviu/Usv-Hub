import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/grade/data/models/course_model.dart';
import 'package:usv_hub/features/schedule/domain/entities/schedule_entity.dart';

@LazySingleton()
class ScheduleFirestoreApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  Future<List<ScheduleEntity>> getStudentSchedule() async {
    try {
      final String userId = user!.uid;
      final List<ScheduleEntity> scheduleList = [];

      final response = await _firestore
          .collection(AppCollections.semesterXStudentCollection)
          .where(
            AppFields.studentId,
            isEqualTo: userId,
          )
          .where(AppFields.isActive, isEqualTo: true)
          .get();

      final semesterId = response.docs.first.get(AppFields.semesterId);

      final courses = await _firestore
          .collection(AppCollections.courseCollection)
          .where(AppFields.semesterId, isEqualTo: semesterId)
          .get();

      for (final doc in courses.docs) {
        final CourseModel courseModel = CourseModel.fromMap(doc.data());

        for (final schedule in courseModel.scheduleMap) {
          final ClassType classType = schedule[AppFields.classType];
          String teacherName = '';

          final teacher = await _firestore
              .collection(AppCollections.teacher)
              .where(
                AppFields.id,
                isEqualTo: classType == ClassType.curs
                    ? courseModel.teacherId
                    : courseModel.assistentId,
              )
              .get();
          teacher.docs.first.data().forEach((key, value) {
            if (key == AppFields.name) {
              teacherName = value;
            }
          });

          ScheduleEntity scheduleEntity = ScheduleEntity(
              courseTitle: courseModel.title,
              dayOfWeek: schedule[AppFields.dayOfWeek],
              startingHour: schedule[AppFields.startingHour],
              endingHour: schedule[AppFields.endingHour],
              classType: schedule[AppFields.classType],
              sala: schedule[AppFields.classNumber],
              teacher: teacherName,
              courseFrequency: schedule[AppFields.courseFrequency]);
          scheduleList.add(scheduleEntity);
        }
      }
      return scheduleList;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    } on Exception catch (e) {
      throw MediumException(runtimeType, e.toString());
    }
  }
}
