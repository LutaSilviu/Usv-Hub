part of 'submission_cubit.dart';

sealed class SubmissionState extends Equatable {
  const SubmissionState();

  @override
  List<Object> get props => [];
}

final class SubmissionInitial extends SubmissionState {}

final class SubmissionLoading extends SubmissionState {}

final class SubmissionError extends SubmissionState {
  final String message;

  const SubmissionError(this.message);
  @override
  List<Object> get props => [message];
}

final class SubmissionLoaded extends SubmissionState {
  final Map<SubmisionEntity, String> submissions;

  const SubmissionLoaded(this.submissions);
  @override
  List<Object> get props => [submissions];
}
