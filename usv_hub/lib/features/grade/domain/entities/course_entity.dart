// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class CourseEntity extends Equatable {
  final String id;
  final String teacherId;
  final String assistentId;
  final String title;
  final int classNumber;
  final int courseCredits;
  final String semester;
  final List<Map<String, dynamic>> scheduleMap;

  const CourseEntity({
    required this.id,
    required this.teacherId,
    required this.assistentId,
    required this.title,
    required this.classNumber,
    required this.courseCredits,
    required this.scheduleMap,
    required this.semester,
  });

  @override
  List<Object?> get props => [
        id,
        teacherId,
        assistentId,
        title,
        classNumber,
        courseCredits,
        scheduleMap,
        semester
      ];
}
