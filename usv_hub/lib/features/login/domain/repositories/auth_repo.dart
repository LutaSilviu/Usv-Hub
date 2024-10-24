import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';

abstract class AuthRepo {
  Future<void> login({required String email, required String password});
  Future<void> logout();
  Future<Either<Failure, UserEntity>> getUserEntity();
  Future<bool> isLoggedIn();
}
