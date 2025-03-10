import 'package:equatable/equatable.dart';

class ScheduleEntity extends Equatable {
  final String courseTitle;
  final int dayOfWeek;
  final int startingHour;
  final int endingHour;
  final String sala;
  final String teacher;
  final ClassType classType;
  final CourseFrequency courseFrequency;

  const ScheduleEntity({
    required this.courseTitle,
    required this.dayOfWeek,
    required this.startingHour,
    required this.endingHour,
    required this.classType,
    required this.sala,
    required this.teacher,
    required this.courseFrequency,
  });

  @override
  List<Object?> get props => [
        courseTitle,
        dayOfWeek,
        startingHour,
        endingHour,
        classType,
        sala,
        teacher,
        courseFrequency,
      ];
}

enum ClassType { course, laboratory }

extension ClassTypeToString on ClassType {
  String get stringValue {
    switch (this) {
      case ClassType.course:
        return 'Course';
      case ClassType.laboratory:
        return 'Laboratory';
    }
  }
}

extension StringToClassType on String {
  ClassType get toClassType {
    switch (toLowerCase()) {
      case 'course':
        return ClassType.course;
      case 'laboratory':
        return ClassType.laboratory;
      default:
        return ClassType.course;
    }
  }
}

enum CourseFrequency { saptamaniPare, saptamaniImpare, toateSaptamanile }

extension CourseFrequencyToString on CourseFrequency {
  String get stringValue {
    switch (this) {
      case CourseFrequency.saptamaniPare:
        return 'Saptamani pare';
      case CourseFrequency.saptamaniImpare:
        return 'Saptamani impare';
      case CourseFrequency.toateSaptamanile:
        return 'Toate saptamanile';
    }
  }
}

extension StringToCourseFrequency on String {
  CourseFrequency? toCourseFrequency() {
    switch (toLowerCase()) {
      case 'saptamani pare':
        return CourseFrequency.saptamaniPare;
      case 'saptamani impare':
        return CourseFrequency.saptamaniImpare;
      case 'toate saptamanile':
        return CourseFrequency.toateSaptamanile;
      default:
        return null;
    }
  }
}
