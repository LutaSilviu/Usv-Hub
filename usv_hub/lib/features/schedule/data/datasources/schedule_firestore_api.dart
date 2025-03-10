import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/select_course/data/models/course_model.dart';
import 'package:usv_hub/features/schedule/domain/entities/schedule_entity.dart';

@LazySingleton()
class ScheduleFirestoreApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<List<ScheduleEntity>> getStudentSchedule() async {
    try {
      final String userId = _firebaseAuth.currentUser!.uid;
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
          String classTypeString = schedule[AppFields.classType];
          final ClassType classType = classTypeString.toClassType;
          String teacherName = '';

          final teacher = await _firestore
              .collection(AppCollections.teacher)
              .where(
                AppFields.id,
                isEqualTo: classType == ClassType.course
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
              classType: classType,
              sala: schedule[AppFields.classWhereHeld],
              teacher: teacherName,
              courseFrequency: (schedule[AppFields.courseFrequency] as String)
                  .toCourseFrequency()!);
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

  Future<List<ScheduleEntity>> getTeacherSchedule() async {
    try {
      final String userId = _firebaseAuth.currentUser!.uid;
      final List<ScheduleEntity> scheduleList = [];

      final coursesForTeacher = await _firestore
          .collection(AppCollections.courseCollection)
          .where(AppFields.teacherId, isEqualTo: userId)
          .get();

      final coursesForAssistent = await _firestore
          .collection(AppCollections.courseCollection)
          .where(AppFields.assistentId, isEqualTo: userId)
          .get();

      for (final doc in coursesForTeacher.docs) {
        final CourseModel courseModel = CourseModel.fromMap(doc.data());

        for (final schedule in courseModel.scheduleMap) {
          String classTypeString = schedule[AppFields.classType];
          final ClassType classType = classTypeString.toClassType;
          if (classType == ClassType.course) {
            ScheduleEntity scheduleEntity = ScheduleEntity(
                courseTitle: courseModel.title,
                dayOfWeek: schedule[AppFields.dayOfWeek],
                startingHour: schedule[AppFields.startingHour],
                endingHour: schedule[AppFields.endingHour],
                classType: classType,
                sala: schedule[AppFields.classWhereHeld],
                teacher: '',
                courseFrequency: (schedule[AppFields.courseFrequency] as String)
                    .toCourseFrequency()!);
            scheduleList.add(scheduleEntity);
          }
        }
      }
      for (final doc in coursesForAssistent.docs) {
        final CourseModel courseModel = CourseModel.fromMap(doc.data());

        for (final schedule in courseModel.scheduleMap) {
          String classTypeString = schedule[AppFields.classType];
          final ClassType classType = classTypeString.toClassType;
          if (classType == ClassType.laboratory) {
            ScheduleEntity scheduleEntity = ScheduleEntity(
                courseTitle: courseModel.title,
                dayOfWeek: schedule[AppFields.dayOfWeek],
                startingHour: schedule[AppFields.startingHour],
                endingHour: schedule[AppFields.endingHour],
                classType: classType,
                sala: schedule[AppFields.classWhereHeld],
                teacher: '',
                courseFrequency: (schedule[AppFields.courseFrequency] as String)
                    .toCourseFrequency()!);
            scheduleList.add(scheduleEntity);
          }
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
