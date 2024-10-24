part of 'potential_contacts_cubit.dart';

sealed class PotentialContactsState extends Equatable {
  const PotentialContactsState();

  @override
  List<Object> get props => [];
}

final class PotentialContactsInitial extends PotentialContactsState {}

final class PotentialContactsLoading extends PotentialContactsState {}

final class PotentialContactsError extends PotentialContactsState {
  final String message;

  const PotentialContactsError(this.message);
}

final class PotentialContactsLoaded extends PotentialContactsState {
  final List<UserEntity> contacts;

  const PotentialContactsLoaded(this.contacts);
}
