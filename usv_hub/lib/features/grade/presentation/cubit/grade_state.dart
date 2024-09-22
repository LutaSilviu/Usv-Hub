// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'grade_cubit.dart';

abstract class GradeState extends Equatable {
  const GradeState();

  @override
  List<Object> get props => [];
}

class GradeInitial extends GradeState {}

class LoadingState extends GradeState {}

class CoursesLoadedState extends GradeState {
  final Map<GradeEntity, CourseEntity> mapCoursesGrades;
  const CoursesLoadedState({
    required this.mapCoursesGrades,
  });

  @override
  List<Object> get props => [mapCoursesGrades];
}

class CourseSelected extends GradeState {
  final CourseEntity course;
  final GradeEntity grade;
  const CourseSelected({
    required this.course,
    required this.grade,
  });
  @override
  List<Object> get props => [course, grade];
}

class ErrorState extends GradeState {
  final String message;
  const ErrorState({
    required this.message,
  });
}
