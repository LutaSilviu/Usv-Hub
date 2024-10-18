import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/events/data/datasources/event_service_api.dart';
import 'package:usv_hub/features/events/domain/entities/event_entity.dart';
import 'package:usv_hub/features/events/domain/repositories/event_repo.dart';

@LazySingleton(as: EventRepo)
class EventRepoImpl extends EventRepo {
  final EventServiceApi _eventServiceApi;
  EventRepoImpl(this._eventServiceApi);
  @override
  Future<Either<Failure, List<EventEntity>>> getEvents() async {
    try {
      return Right(await _eventServiceApi.getEvents());
    } on MediumException catch (e) {
      return Left(MediumFailure(
        message: e.message,
      ));
    }
  }
}
