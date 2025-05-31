import 'package:equatable/equatable.dart';
import 'package:usv_hub/core/utils/consts.dart';

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
