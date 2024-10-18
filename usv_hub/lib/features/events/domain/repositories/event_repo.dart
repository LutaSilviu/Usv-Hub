import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/events/domain/entities/event_entity.dart';

abstract class EventRepo {
  Future<Either<Failure, List<EventEntity>>> getEvents();
}
