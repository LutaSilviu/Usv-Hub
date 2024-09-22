import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:usv_hub/core/errors/failures.dart';

@LazySingleton()
class AuthenticationValidator {
  bool _isEmailValid(String? email) {
    bool emailValid = true;
    if (email == null || email.isEmpty || !email.contains('@')) {
      emailValid = false;
    }
    return emailValid;
  }

  bool _isPasswordValid(String? password) {
    if (password == null || password.isEmpty || password.length < 6) {
      return false;
    }
    return true;
  }

  bool isNameValid(String? name) {
    if (name == null || name.isEmpty) {
      return false;
    }
    return true;
  }

  Either<Failure<String>, void> areLoginInformationValid(
    String? email,
    String? password,
  ) {
    if (!_isEmailValid(email)) {
      return Left(
        FieldFailure(message: 'Invalid email'),
      );
    } else if (!_isPasswordValid(password)) {
      return Left(
        FieldFailure(message: 'Invalid password'),
      );
    }
    return const Right(null);
  }
}
