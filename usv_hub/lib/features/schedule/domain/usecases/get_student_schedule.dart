import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/schedule/domain/entities/schedule_entity.dart';
import 'package:usv_hub/features/schedule/domain/repositories/schedule_repo.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class GetStudentSchedule
    implements Usecase<Either<Failure, List<ScheduleEntity>>, bool> {
  final ScheduleRepo _scheduleRepo;

  GetStudentSchedule(
    this._scheduleRepo,
  );

  @override
  Future<Either<Failure, List<ScheduleEntity>>> call({required bool params}) {
    return _scheduleRepo.getSchedule(params);
  }
}
