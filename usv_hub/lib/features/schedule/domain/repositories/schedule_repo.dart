import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/schedule/domain/entities/schedule_entity.dart';

abstract class ScheduleRepo {
  Future<Either<Failure, List<ScheduleEntity>>> getStudentSchedule();
}
