import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';
import 'package:usv_hub/features/login/domain/repositories/auth_repo.dart';

@injectable
class UserProvider extends ChangeNotifier {
  AuthRepo authRepo;
  UserProvider({required this.authRepo});
  bool isLoading = false;
  String? errorMessage;
  UserEntity? user;
  SelectedType _selectedType = SelectedType.none;

  SelectedType get selectedType => _selectedType;

  void selectType(SelectedType type) {
    _selectedType = type;
    notifyListeners();
  }

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
        _selectedType = r.keys.first;
        user = r.values.first;
      },
    );
    isLoading = false;
    notifyListeners();
  }
}
