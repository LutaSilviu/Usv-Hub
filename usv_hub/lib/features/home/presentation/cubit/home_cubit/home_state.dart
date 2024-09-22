part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class TriggerDrawer extends HomeState {
  final bool isDrawerOpen;

  TriggerDrawer({this.isDrawerOpen = false});

  @override
  List<Object> get props => [isDrawerOpen];
}
