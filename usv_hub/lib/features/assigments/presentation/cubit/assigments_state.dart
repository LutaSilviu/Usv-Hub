part of 'assigments_cubit.dart';

abstract class AssigmentsState extends Equatable {
  const AssigmentsState();

  @override
  List<Object> get props => [];
}

class AssigmentsInitial extends AssigmentsState {}

class AssigmentsLoading extends AssigmentsState {}

class AssigmentsLoaded extends AssigmentsState {
  final List<AssigmentEntity> assigments;

  const AssigmentsLoaded(this.assigments);

  @override
  List<Object> get props => [assigments];
}

class CoursesLoaded extends AssigmentsState {
  final Map<ProfesorType, CourseEntity> courses;

  const CoursesLoaded(this.courses);

  @override
  List<Object> get props => [courses];
}

class AssigmentsError extends AssigmentsState {
  final String message;

  const AssigmentsError(this.message);

  @override
  List<Object> get props => [message];
}
