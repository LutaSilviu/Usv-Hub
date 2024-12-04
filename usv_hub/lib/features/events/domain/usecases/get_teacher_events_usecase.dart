import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/usecase/usecase.dart';
import 'package:usv_hub/features/events/domain/entities/event_entity.dart';
import 'package:usv_hub/features/events/domain/repositories/event_repo.dart';

@LazySingleton()
class GetTeacherEventsUsecase
    extends Usecase<Either<Failure, List<EventEntity>>, void> {
  final EventRepo _eventRepo;
  GetTeacherEventsUsecase(this._eventRepo);
  @override
  Future<Either<Failure, List<EventEntity>>> call({void params}) {
    return _eventRepo.getEventsForTeacher();
  }
}
