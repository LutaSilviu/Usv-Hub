// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'attendance_cubit.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class LoadingState extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final AttendanceEntity attendance;
  const AttendanceLoaded({
    required this.attendance,
  });
  @override
  List<Object> get props => [attendance];
}

class TeacherCoursesLoadedState extends AttendanceState {
  final Map<ProfesorType, CourseEntity> mapCoursesGrades;

  const TeacherCoursesLoadedState({required this.mapCoursesGrades});
  @override
  List<Object> get props => [mapCoursesGrades];
}

class AttendanceError extends AttendanceState {
  final String errorMessage;

  const AttendanceError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
