import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({required super.name, required super.email, required super.id});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[AppFields.id],
      name: json[AppFields.name],
      email: json[AppFields.email],
    );
  }
}
