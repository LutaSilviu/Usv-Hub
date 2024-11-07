import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/attendance/domain/entities/attendance_entity.dart';
import 'package:usv_hub/features/attendance/domain/repositories/attendance_repository.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class AddAttandance extends Usecase<Either<Failure, void>, AttendanceEntity> {
  final AttendanceRepository _repository;

  AddAttandance(this._repository);
  @override
  Future<Either<Failure, void>> call({required AttendanceEntity params}) async {
    return _repository.addAttendance(params);
  }
}
