import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/events/domain/entities/event_entity.dart';
import 'package:usv_hub/features/events/domain/usecases/get_events_usecase.dart';

part 'events_state.dart';

@injectable
class EventsCubit extends Cubit<EventsState> {
  final GetEventsUsecase _getEventsUsecase;
  EventsCubit(this._getEventsUsecase) : super(EventsInitial());

  Future<void> getEvents() async {
    emit(EventsLoading());

    (await _getEventsUsecase.call()).fold(
      (l) => emit(
        EventsError(l.message),
      ),
      (r) => emit(
        EventsLoaded(r),
      ),
    );
  }
}
