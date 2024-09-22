import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/login/domain/repositories/auth_repo.dart';
import 'package:usv_hub/features/login/domain/validators.dart';

@lazySingleton
class AuthUseCase {
  final AuthRepo authRepo;
  final AuthenticationValidator fieldValidator;
  AuthUseCase({required this.authRepo, required this.fieldValidator});

  Future<Either<Failure<String>, void>> login({
    required String email,
    required String password,
  }) async {
    return fieldValidator.areLoginInformationValid(email, password).fold(
      left,
      (r) async {
        try {
          final authResponse = await authRepo.login(
            email: email.trim(),
            password: password,
          );
          return Right(authResponse);
        } on MediumException catch (e) {
          return Left(MediumFailure(message: e.message));
        }
      },
    );
  }

  Future<Either<Failure<String>, void>> logout() async {
    try {
      final authResponse = await authRepo.logout();
      return Right(authResponse);
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }

  Future<bool> isLoggedIn() async {
    final authResponse = await authRepo.isLoggedIn();
    return authResponse;
  }
}
