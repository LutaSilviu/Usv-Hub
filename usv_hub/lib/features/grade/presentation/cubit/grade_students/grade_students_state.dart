part of 'grade_students_cubit.dart';

sealed class GradeStudentsState extends Equatable {
  const GradeStudentsState();

  @override
  List<Object> get props => [];
}

final class GradeStudentsInitial extends GradeStudentsState {}

final class GradeStudentsLoaded extends GradeStudentsState {
  final List<UserEntity> students;

  const GradeStudentsLoaded(this.students);

  @override
  List<Object> get props => [students];
}

final class ErrorState extends GradeStudentsState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object> get props => [message];
}

final class LoadingState extends GradeStudentsState {}
