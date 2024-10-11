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

enum ClassType { curs, laborator, seminar }

extension ClassTypeToString on ClassType {
  String get stringValue {
    switch (this) {
      case ClassType.curs:
        return 'Curs';
      case ClassType.laborator:
        return 'Laborator';
      case ClassType.seminar:
        return 'Seminar';
      default:
        return '';
    }
  }
}

extension StringToClassType on String {
  ClassType? toClassType() {
    switch (toLowerCase()) {
      case 'curs':
        return ClassType.curs;
      case 'laborator':
        return ClassType.laborator;
      case 'seminar':
        return ClassType.seminar;
      default:
        return null;
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
      default:
        return '';
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
