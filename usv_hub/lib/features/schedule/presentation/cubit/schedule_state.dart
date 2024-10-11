part of 'schedule_cubit.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class LoadingState extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final List<ScheduleEntity> schedule;

  const ScheduleLoaded({required this.schedule});

  @override
  List<Object> get props => [schedule];
}

class ErrorState extends ScheduleState {
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
