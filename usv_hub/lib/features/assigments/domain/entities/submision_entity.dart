import 'package:equatable/equatable.dart';

class SubmisionEntity extends Equatable {
  final String id;
  final String assigmentId;
  final String studentId;
  final String title;
  final String description;
  final DateTime startingDate;
  final DateTime endingTime;

  const SubmisionEntity(this.id, this.assigmentId, this.studentId, this.title,
      this.description, this.startingDate, this.endingTime);

  @override
  List<Object?> get props => [
        id,
        assigmentId,
        studentId,
        title,
        description,
        startingDate,
        endingTime
      ];
}
