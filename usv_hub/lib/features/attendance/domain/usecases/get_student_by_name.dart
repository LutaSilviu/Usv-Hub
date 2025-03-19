import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/attendance/domain/repositories/attendance_repository.dart';

import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';

@lazySingleton
class GetStudentByName extends Usecase<Either<Failure, UserEntity>, String> {
  final AttendanceRepository _repository;

  GetStudentByName(this._repository);
  @override
  Future<Either<Failure, UserEntity>> call({required String params}) async {
    return _repository.getStudentAfterName(params);
  }
}
