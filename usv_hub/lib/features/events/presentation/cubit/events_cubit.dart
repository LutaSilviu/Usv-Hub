import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/utils/extensions.dart';
import 'package:usv_hub/features/events/domain/entities/event_entity.dart';
import 'package:usv_hub/features/events/domain/usecases/get_events_usecase.dart';
import 'package:usv_hub/features/events/domain/usecases/get_teacher_events_usecase.dart';

part 'events_state.dart';

@injectable
class EventsCubit extends Cubit<EventsState> {
  final GetEventsUsecase _getEventsUsecase;
  final GetTeacherEventsUsecase _getTeacherEventsUsecase;
  EventsCubit(this._getEventsUsecase, this._getTeacherEventsUsecase)
      : super(EventsInitial());

  Future<void> getEvents(bool isTeacher) async {
    safeEmit(EventsLoading());
    if (!isTeacher) {
      (await _getEventsUsecase.call()).fold(
        (l) => safeEmit(
          EventsError(l.message),
        ),
        (r) => safeEmit(
          EventsLoaded(r),
        ),
      );
    } else {
      (await _getTeacherEventsUsecase.call()).fold(
        (l) => safeEmit(
          EventsError(l.message),
        ),
        (r) => safeEmit(
          EventsLoaded(r),
        ),
      );
    }
  }
}
