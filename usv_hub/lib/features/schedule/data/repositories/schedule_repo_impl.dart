import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/schedule/data/datasources/schedule_firestore_api.dart';
import 'package:usv_hub/features/schedule/domain/entities/schedule_entity.dart';
import 'package:usv_hub/features/schedule/domain/repositories/schedule_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ScheduleRepo)
class ScheduleRepoImpl extends ScheduleRepo {
  final ScheduleFirestoreApi scheduleFirestoreApi;

  ScheduleRepoImpl(this.scheduleFirestoreApi);

  @override
  Future<Either<Failure, List<ScheduleEntity>>> getSchedule(
      bool isTeacher) async {
    try {
      if (isTeacher) {
        return Right(await scheduleFirestoreApi.getTeacherSchedule());
      }
      return Right(await scheduleFirestoreApi.getStudentSchedule());
    } on MediumFailure catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }
}
