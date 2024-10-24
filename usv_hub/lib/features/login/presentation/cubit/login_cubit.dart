import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/login/domain/usecases/auth_usecase.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthUseCase authUseCase;
  LoginCubit({required this.authUseCase}) : super(LoginInitial());

  //appStarted
  Future<void> checkLogin() async {
    emit(LoginLoading());

    final result = await authUseCase.isLoggedIn();

    if (result) {
      emit(LoginSuccess());
    } else {
      emit(LoginInitial());
    }
  }

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    emit(LoginLoading());
    try {
      await authUseCase.login(email: email, password: password).then((value) {
        value.fold(
          (l) => emit(LoginFailure(l.toString())),
          (r) async {
            emit(LoginSuccess());
          },
        );
      });
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(LoginLoading());
    try {
      await authUseCase.logout().then((value) {
        value.fold(
          (l) => emit(LoginFailure(l.toString())),
          (r) => emit(LoginInitial()),
        );
      });
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
