part of 'select_course_cubit.dart';

abstract class SelectCourseState extends Equatable {
  const SelectCourseState();

  @override
  List<Object> get props => [];
}

class SelectCourseInitial extends SelectCourseState {}

class CoursesLoading extends SelectCourseState {}

class CoursesLoaded extends SelectCourseState {
  final List<Map<ProfesorType, CourseEntity>> courses = [];

  CoursesLoaded(Map<ProfesorType, List<CourseEntity>> courses) {
    for (var entry in courses.entries) {
      for (var course in entry.value) {
        this.courses.add({entry.key: course});
      }
    }
  }

  @override
  List<Object> get props => [courses];
}

class CoursesError extends SelectCourseState {
  final String message;

  const CoursesError(this.message);

  @override
  List<Object> get props => [message];
}
