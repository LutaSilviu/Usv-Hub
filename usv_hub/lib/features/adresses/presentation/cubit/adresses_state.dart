part of 'adresses_cubit.dart';

abstract class AddressesState extends Equatable {
  const AddressesState();

  @override
  List<Object> get props => [];
}

class AdressesInitial extends AddressesState {}

class LoadingState extends AddressesState {}

class ErrorState extends AddressesState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class SuccessState extends AddressesState {
  final List<Map<String, String>> addresses;

  const SuccessState(this.addresses);

  @override
  List<Object> get props => [addresses];
}
