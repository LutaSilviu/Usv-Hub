import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';
import 'package:usv_hub/features/login/data/datasources/authentication_firestore_api.dart';
import 'package:usv_hub/features/login/domain/repositories/auth_repo.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  final AuthenticationFirestoreApi authFirestoreApi;

  AuthRepoImpl(this.authFirestoreApi);

  @override
  Future<bool> isLoggedIn() {
    return authFirestoreApi.isLoggedIn();
  }

  @override
  Future<void> login({required String email, required String password}) {
    try {
      return authFirestoreApi.login(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      String errorMessage = error.message!;

      if (error.code == 'user-not-found') {
        errorMessage = AppStringFailuresMessages.userNotFound;
      } else if (error.code == 'wrong-password') {
        errorMessage = AppStringFailuresMessages.wrongPassword;
      }

      throw MediumException(runtimeType, errorMessage);
    }
  }

  @override
  Future<void> logout() {
    try {
      return authFirestoreApi.logout();
    } on FirebaseAuthException catch (error) {
      throw MediumException(runtimeType, error.message!);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserEntity() async {
    try {
      return Right(await authFirestoreApi.getUserModel());
    } on FirebaseAuthException catch (error) {
      return Left(MediumFailure(message: error.message!));
    }
  }
}
