import 'package:equatable/equatable.dart';

class SubmisionEntity extends Equatable {
  final String id;
  final String assigmentId;
  final String studentId;
  final String downloadUrl;
  final DateTime postDate;

  const SubmisionEntity(
    this.id,
    this.assigmentId,
    this.studentId,
    this.downloadUrl,
    this.postDate,
  );

  @override
  List<Object?> get props => [
        id,
        assigmentId,
        studentId,
        downloadUrl,
        postDate,
      ];
}
