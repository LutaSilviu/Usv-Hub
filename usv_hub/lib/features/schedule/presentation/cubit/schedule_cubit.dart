import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usv_hub/features/schedule/domain/entities/schedule_entity.dart';

import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/schedule/domain/usecases/get_student_schedule.dart';

part 'schedule_state.dart';

@injectable
class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit(this._getStudentSchedule) : super(ScheduleInitial());
  final GetStudentSchedule _getStudentSchedule;
  Future<void> getSchedule() async {
    emit(LoadingState());

    (await _getStudentSchedule.call()).fold(
      (l) {
        emit(ErrorState(message: l.message));
      },
      (r) {
        emit(ScheduleLoaded(schedule: r));
      },
    );
  }
}
