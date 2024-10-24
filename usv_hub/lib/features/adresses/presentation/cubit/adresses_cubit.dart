import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/utils/consts.dart';

import 'package:usv_hub/features/adresses/domain/repositories/addresses_repo.dart';

part 'adresses_state.dart';

@injectable
class AddressesCubit extends Cubit<AddressesState> {
  final AddressesRepo _addressesRepo;
  AddressesCubit(
    this._addressesRepo,
  ) : super(AdressesInitial());

  Future<void> getAddresses() async {
    emit(LoadingState());

    (await _addressesRepo.getAddresses()).fold(
      (l) => emit(ErrorState(l.message)),
      (r) => emit(SuccessState(r)),
    );
  }

  Future<void> postAddresses(String address) async {
    if (state is SuccessState) {
      List<Map<String, String>> addresses = (state as SuccessState).addresses;

      emit(LoadingState());

      (await _addressesRepo.postAddresses(address)).fold(
        (l) => emit(ErrorState(l.message)),
        (r) {
          addresses.add(r);
          emit(SuccessState(addresses));
        },
      );
    }
  }

  Future<void> editAddresses(String id, String address) async {
    if (state is SuccessState) {
      List<Map<String, String>> addresses = (state as SuccessState).addresses;

      emit(LoadingState());

      (await _addressesRepo.editAddresses(id, address)).fold(
        (l) => emit(ErrorState(l.message)),
        (r) {
          addresses.removeWhere((element) => element[AppFields.id] == id);
          addresses.add(r);
          addresses.sort(
              (a, b) => a[AppFields.address]!.compareTo(b[AppFields.address]!));
          emit(SuccessState(addresses));
        },
      );
    }
  }
}
