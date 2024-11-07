// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'grade_cubit.dart';

abstract class GradeState extends Equatable {
  const GradeState();

  @override
  List<Object> get props => [];
}

class GradeInitial extends GradeState {}

class LoadingState extends GradeState {}

class GradeLoadedState extends GradeState {
  final GradeEntity grade;
  const GradeLoadedState({
    required this.grade,
  });

  @override
  List<Object> get props => [];
}

class ErrorState extends GradeState {
  final String message;
  const ErrorState({
    required this.message,
  });
}
