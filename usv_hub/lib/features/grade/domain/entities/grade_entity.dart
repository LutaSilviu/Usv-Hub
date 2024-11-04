import 'package:equatable/equatable.dart';

class GradeEntity extends Equatable {
  final String id;
  final String studentId;
  final double? courseGrade;
  final double? labGrade;
  final String courseId;

  const GradeEntity({
    required this.id,
    required this.studentId,
    required this.courseGrade,
    required this.labGrade,
    required this.courseId,
  });

  @override
  List<Object?> get props => [
        id,
        studentId,
        courseGrade,
        labGrade,
        courseId,
      ];
}
