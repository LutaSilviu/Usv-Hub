part of 'select_course_cubit.dart';

abstract class SelectCourseState extends Equatable {
  const SelectCourseState();

  @override
  List<Object> get props => [];
}

class SelectCourseInitial extends SelectCourseState {}

class CoursesLoading extends SelectCourseState {}

class CoursesLoaded extends SelectCourseState {
  final Map<ProfesorType, CourseEntity> courses;

  const CoursesLoaded(this.courses);

  @override
  List<Object> get props => [courses];
}

class CoursesError extends SelectCourseState {
  final String message;

  const CoursesError(this.message);

  @override
  List<Object> get props => [message];
}
