import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/adresses/data/datasources/addresses_api_service.dart';
import 'package:usv_hub/features/adresses/domain/repositories/addresses_repo.dart';

@LazySingleton(as: AddressesRepo)
class AddressesRepoImpl extends AddressesRepo {
  final AddressesApiService _addressesApiService;
  AddressesRepoImpl(this._addressesApiService);

  @override
  Future<Either<Failure, List<Map<String, String>>>> getAddresses() async {
    try {
      return Right(await _addressesApiService.getAddresses());
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, String>>> postAddresses(
      String address) async {
    try {
      return Right(await _addressesApiService.postAddresses(address));
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, String>>> editAddresses(
      String id, String address) async {
    try {
      return Right(await _addressesApiService.editAddresses(id, address));
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }
}
