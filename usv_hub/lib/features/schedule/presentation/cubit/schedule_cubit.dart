import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usv_hub/core/utils/extensions.dart';
import 'package:usv_hub/features/schedule/domain/entities/schedule_entity.dart';

import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/schedule/domain/usecases/get_student_schedule.dart';

part 'schedule_state.dart';

@injectable
class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit(this._getStudentSchedule) : super(ScheduleInitial());
  final GetStudentSchedule _getStudentSchedule;
  Future<void> getSchedule(bool isTeacher) async {
    safeEmit(LoadingState());

    (await _getStudentSchedule.call(params: isTeacher)).fold(
      (l) {
        safeEmit(ErrorState(message: l.message));
      },
      (r) {
        safeEmit(ScheduleLoaded(schedule: r));
      },
    );
  }
}
