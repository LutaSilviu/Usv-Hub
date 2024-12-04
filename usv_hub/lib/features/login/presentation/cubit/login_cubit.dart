import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/utils/extensions.dart';
import 'package:usv_hub/features/login/domain/usecases/auth_usecase.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthUseCase authUseCase;
  LoginCubit({required this.authUseCase}) : super(LoginInitial());
  //appStarted
  Future<void> checkLogin(BuildContext context) async {
    safeEmit(LoginLoading());

    final result = await authUseCase.isLoggedIn();

    if (result) {
      safeEmit(LoginSuccess());
    } else {
      safeEmit(LoginInitial());
    }
  }

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    safeEmit(LoginLoading());
    try {
      await authUseCase.login(email: email, password: password).then((value) {
        value.fold(
          (l) => safeEmit(LoginFailure(l.toString())),
          (r) async {
            safeEmit(LoginSuccess());
          },
        );
      });
    } catch (e) {
      safeEmit(LoginFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    safeEmit(LoginLoading());
    try {
      await authUseCase.logout().then((value) {
        value.fold(
          (l) => safeEmit(LoginFailure(l.toString())),
          (r) => safeEmit(LoginInitial()),
        );
      });
    } catch (e) {
      safeEmit(LoginFailure(e.toString()));
    }
  }
}
