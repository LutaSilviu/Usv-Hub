import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';

abstract class AddressesRepo {
  Future<Either<Failure, List<Map<String, String>>>> getAddresses();
  Future<Either<Failure, Map<String, String>>> postAddresses(String address);
  Future<Either<Failure, Map<String, String>>> editAddresses(
      String id, String address);
}
