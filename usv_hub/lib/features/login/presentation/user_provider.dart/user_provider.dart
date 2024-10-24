import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';
import 'package:usv_hub/features/login/domain/repositories/auth_repo.dart';

@injectable
class UserProvider extends ChangeNotifier {
  AuthRepo authRepo;
  UserProvider({required this.authRepo});
  bool isLoading = false;
  String? errorMessage;
  UserEntity? user;

  get getUser => user;
  get getIsLoading => isLoading;

  setUser(UserEntity user) {
    this.user = user;
    notifyListeners();
  }

  set setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> fetchUserEntity() async {
    isLoading = true;
    notifyListeners();
    (await authRepo.getUserEntity()).fold(
      (l) {
        errorMessage = l.message;
      },
      (r) {
        user = r;
      },
    );
    isLoading = false;
    notifyListeners();
  }
}
