part of 'add_grade_cubit.dart';

sealed class AddGradeState extends Equatable {
  const AddGradeState();

  @override
  List<Object> get props => [];
}

final class AddGradeInitial extends AddGradeState {}

final class LoadingState extends AddGradeState {}

final class GradeLoaded extends AddGradeState {
  final GradeEntity? grade;

  const GradeLoaded(this.grade);
}

final class ErrorState extends AddGradeState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object> get props => [message];
}
