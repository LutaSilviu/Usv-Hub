import 'package:equatable/equatable.dart';

class AssigmentEntity extends Equatable {
  final String id;
  final String courseId;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;

  const AssigmentEntity({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
  });

  @override
  List<Object?> get props =>
      [id, courseId, title, description, startTime, endTime];
}
